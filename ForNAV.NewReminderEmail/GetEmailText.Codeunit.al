codeunit 74100 "PTE Get Email Text"
{
    // Copyright (c) 2017-2025 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    /// <summary>
    /// Get the email text for a Reminder
    /// Item
    /// </summary>
    /// <param name="EmailText">ForNAV Email Text temporary table.</param>
    /// <param name="SourceRec">A variant of type Record or RecordRef that represents the source table.</param>///
    procedure GetEmailText(var EmailText: Record "PTE Email Text"; SourceRec: Variant)
    var
        RecordRefLibrary: Codeunit "ForNAV RecordRef Library";
        RecRef: RecordRef;
        Handled: Boolean;
    begin
        EmailText.DeleteAll();

        OnBeforeGetEmailText(EmailText, SourceRec, Handled);
        if Handled then
            exit;

        RecordRefLibrary.ConvertToRecRefVar(SourceRec, RecRef);
        case RecRef.Number of
            Database::"Issued Reminder Header":
                GetReminderEmailText(EmailText, SourceRec);
        end;
    end;

    local procedure GetReminderEmailText(var EmailText: Record "PTE Email Text"; SourceRecRef: RecordRef)
    var
        IssuedReminderHeader: Record "Issued Reminder Header";
        ReminderEmailText: Record "Reminder Email Text";
        os: OutStream;
        BodyText: Text;
    begin
        SourceRecRef.SetTable(IssuedReminderHeader);
        ReminderEmailText.SetAutoCalcFields("Body Text");
        if not GetReminderEmailText(IssuedReminderHeader, ReminderEmailText) then
            exit;

        EmailText."Entry No." += 1;
        EmailText."Language Code" := ReminderEmailText."Language Code";
        EmailText.Subject := CopyStr(SubstituteRelatedValues(ReminderEmailText.Subject, IssuedReminderHeader), 1, MaxStrLen(ReminderEmailText.Subject));
        EmailText.Greeting := CopyStr(SubstituteRelatedValues(ReminderEmailText.Greeting, IssuedReminderHeader), 1, MaxStrLen(ReminderEmailText.Greeting));
        SelectEmailBodyText(ReminderEmailText, IssuedReminderHeader, BodyText);
        EmailText."Body Text".CreateOutStream(os);
        os.WriteText(SubstituteRelatedValues(BodyText, IssuedReminderHeader));
        EmailText.Closing := CopyStr(SubstituteRelatedValues(ReminderEmailText.Closing, IssuedReminderHeader), 1, MaxStrLen(ReminderEmailText.Closing));
        EmailText.Insert();
    end;

    local procedure GetReminderEmailText(var IssuedReminderHeader: Record "Issued Reminder Header"; var ReminderEmailText: Record "Reminder Email Text"): Boolean
    var
        ReminderLevel: Record "Reminder Level";
        ReminderTerms: Record "Reminder Terms";
        LanguageCode: Code[10];
        ReminderLevelNotFoundErr: Label 'Reminder Level %1 on Reminder Term %2 was not found.', Comment = '%1 = Reminder Level No., %2 = Reminder Term Code';
        ReminderTermNotFoundErr: Label 'Reminder Term %1 was not found.', Comment = '%1 = Reminder Term Code';
    begin
        if (IssuedReminderHeader."Reminder Level" = 0) or (IssuedReminderHeader."Reminder Terms Code" = '') then
            exit(false);

        if not ReminderLevel.Get(IssuedReminderHeader."Reminder Terms Code", IssuedReminderHeader."Reminder Level") then
            Error(ReminderLevelNotFoundErr, IssuedReminderHeader."Reminder Level", IssuedReminderHeader."Reminder Terms Code");

        LanguageCode := GetCustomerLanguageOrDefaultUserLanguage(IssuedReminderHeader."Customer No.");
        if ReminderEmailText.Get(ReminderLevel."Reminder Email Text", LanguageCode) then
            exit(true);

        if not ReminderTerms.Get(IssuedReminderHeader."Reminder Terms Code") then
            Error(ReminderTermNotFoundErr, IssuedReminderHeader."Reminder Terms Code");

        if ReminderEmailText.Get(ReminderTerms."Reminder Email Text", LanguageCode) then
            exit(true);

        exit(false);
    end;

    local procedure SelectEmailBodyText(var ReminderEmailText: Record "Reminder Email Text"; var IssuedReminderHeader: Record "Issued Reminder Header"; var BodyTxt: Text)
    var
        TypeHelper: Codeunit "Type Helper";
        EmailBodyTextInStream: InStream;
    begin
        if IssuedReminderHeader."Email Text".HasValue() then begin
            IssuedReminderHeader."Email Text".CreateInStream(EmailBodyTextInStream, TextEncoding::UTF8);
            BodyTxt := TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(EmailBodyTextInStream, TypeHelper.LFSeparator(), IssuedReminderHeader.FieldName("Email Text"));
            exit;
        end;

        BodyTxt += ReminderEmailText.GetBodyText();
    end;

    local procedure SubstituteRelatedValues(Input: Text; var IssuedReminderHeader: Record "Issued Reminder Header"): Text
    var
        FinanceChargeTerms: Record "Finance Charge Terms";
        AutoFormat: Codeunit "Auto Format";
        AutoFormatType: Enum "Auto Format";
    begin
        if IssuedReminderHeader."Fin. Charge Terms Code" <> '' then
            FinanceChargeTerms.Get(IssuedReminderHeader."Fin. Charge Terms Code");

        exit(StrSubstNo(
            Input,
            IssuedReminderHeader."Document Date",
            IssuedReminderHeader."Due Date",
            FinanceChargeTerms."Interest Rate",
            Format(IssuedReminderHeader."Remaining Amount", 0,
                AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, IssuedReminderHeader."Currency Code")),
            IssuedReminderHeader."Interest Amount",
            IssuedReminderHeader."Additional Fee",
            Format(IssuedReminderHeader.CalculateTotalIncludingVAT(), 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, IssuedReminderHeader."Currency Code")),
            IssuedReminderHeader."Reminder Level",
            IssuedReminderHeader."Currency Code",
            IssuedReminderHeader."Posting Date",
            CompanyName,
            IssuedReminderHeader."Add. Fee per Line")
        );
    end;

    local procedure GetCustomerLanguageOrDefaultUserLanguage(CustomerNo: Code[20]): Code[10]
    var
        Customer: Record Customer;
        Language: Codeunit Language;
        LanguageCode: Code[10];
    begin
        if Customer.Get(CustomerNo) then
            LanguageCode := Customer."Language Code";

        if LanguageCode = '' then
            LanguageCode := Language.GetUserLanguageCode();

        if LanguageCode = '' then
            LanguageCode := Language.GetLanguageCode(Language.GetDefaultApplicationLanguageId());

        exit(LanguageCode);
    end;

    [EventSubscriber(ObjectType::CodeUnit, Codeunit::"ForNAV TempTable", OnFillTemporaryTable, '', false, false)]
    local procedure OnFFillTemporaryTable(ReportID: Integer; ChildDataItemId: Text; ParentRecRef: RecordRef; var TempRecRef: RecordRef)
    var
        TempEmailText: Record "PTE Email Text" temporary;
        RecordRefLibrary: Codeunit "ForNAV RecordRef Library";
    begin
        if TempRecRef.Number <> Database::"PTE Email Text" then
            exit;

        TempRecRef.SetTable(TempEmailText);
        GetEmailText(TempEmailText, ParentRecRef);
        Copy(TempRecRef, TempEmailText);
    end;

    local procedure Copy(var ToRecRef: RecordRef; FromVariant: Variant)
    var
        Field: Record Field;
        From: RecordRef;
    begin
        if not ToRecRef.IsTemporary then
            exit;

        ToRecRef.DeleteAll();
        From.GetTable(FromVariant);
        Field.SetRange(TableNo, From.Number);
        Field.SetRange(Class, Field.Class::Normal);
        Field.SetFilter(ObsoleteState, '<>%1', Field.ObsoleteState::Removed);
        Field.SetFilter("No.", '<2000000000');
        if From.FindSet() then
            repeat
                if Field.FindSet() then
                    repeat
                        if Field.Type = Field.Type::BLOB then
                            From.Field(Field."No.").CalcField();
                        ToRecRef.Field(Field."No.").Value(From.Field(Field."No.").Value);
                    until Field.Next() = 0;
                ToRecRef.Insert();
            until From.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeGetEmailText(var EmailText: Record "PTE Email Text"; SourceRec: Variant; var Handled: Boolean)
    begin
    end;
}