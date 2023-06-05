codeunit 90120 "ForNAV Attachment Filename"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetAttachmentFileName', '', false, false)]
    local procedure OnBeforeGetAttachmentFileName(var AttachmentFileName: Text[250]; PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ForNAVLanguageSetup: Record "ForNAV Language Setup";
        ReportSelectionUsage: Enum "Report Selection Usage";
        ReportAsPdfFileNameMsg: Label '%1 %2.pdf', Comment = '%1 = Document Type %2 = Invoice No. or Job Number';
    begin
        if PostedDocNo = '' then
            exit;

        case ReportUsage of
            ReportSelectionUsage::"S.Invoice".AsInteger():
                begin
                    SalesInvoiceHeader.Get(PostedDocNo);
                    ForNAVLanguageSetup.SetRange("Report ID", 0);
                    ForNAVLanguageSetup.SetRange("Language Code", SalesInvoiceHeader."Language Code");
                    ForNAVLanguageSetup.SetRange("Table No.", Database::"Sales Invoice Header");
                    ForNAVLanguageSetup.SetRange("Field No.", 0);
                    if not ForNAVLanguageSetup.FindFirst() then
                        exit;

                    AttachmentFileName := StrSubstNo(ReportAsPdfFileNameMsg, ForNAVLanguageSetup."Translate To", PostedDocNo)
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Layout Reporting", 'OnGenerateFileNameOnAfterAssignFileName', '', false, false)]
    local procedure OnGenerateFileNameOnAfterAssignFileName(var FileName: Text; ReportID: Integer; Extension: Text; DataRecRef: RecordRef)
    var
        AllObjWithCaption: Record AllObjWithCaption;
        Customer: Record Customer;
        ForNAVLanguageSetup: Record "ForNAV Language Setup";
        FilenameLbl: Label '%1 - %2%3', Comment = '%1 = report caption, %2 = customer name, %3 = extension';
    begin
        if DataRecRef.Number <> Database::Customer then
            exit;

        DataRecRef.SetTable(Customer);
        ForNAVLanguageSetup.SetRange("Report ID", ReportID);
        ForNAVLanguageSetup.SetRange("Language Code", Customer."Language Code");
        ForNAVLanguageSetup.SetRange("Table No.", 0);
        ForNAVLanguageSetup.SetRange("Field No.", 0);
        if not ForNAVLanguageSetup.FindFirst() then begin
            AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Report, ReportID);
            FileName := StrSubstNo(FileNameLbl, AllObjWithCaption."Object Caption", Customer.Name, Extension);
            exit;
        end;

        FileName := StrSubstNo(FileNameLbl, ForNAVLanguageSetup."Translate To", Customer.Name, Extension);
    end;
}