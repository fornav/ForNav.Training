codeunit 50150 "ForNAV Get Local File"
{
    /// <summary>
    /// Gets the local file from the table filters.:
    /// The LocalFile needs to have a filter for Alias and for Filename. It will attempt to get the local file based on these two variables
    /// </summary>
    /// <param name="LocalFile">Repeater Line temporary table.</param>
    /// <param name="SourceRec">The parent table. Used to determine item tracking entries.</param>
    procedure FillLocalFiles(var LocalFile: Record "ForNAV Local File"; SourceRec: Variant)
    var
        Handled: Boolean;
    begin
        LocalFile.DeleteAll();
        OnBeforeFillLocalFiles(LocalFile, SourceRec, Handled);
        if Handled then
            exit;

        SetValuesFromFilter(LocalFile);
        AddLocalFiles(LocalFile, SourceRec);
    end;

    internal procedure AddLocalFiles(var LocalFile: Record "ForNAV Local File"; SourceRec: Variant)
    var
        FileService: Codeunit "ForNAV File Service";
        FileOutStream: OutStream;
    begin
        case true of
            LocalFile.Alias = '',
            LocalFile.Filename = '',
            not Fileservice.FileExist(LocalFile.GetPath()):
                exit;
        end;

        LocalFile.Data.CreateOutStream(FileOutStream);
        FileService.ReadFromStream(LocalFile.GetPath(), FileOutStream);
        LocalFile.Insert();
    end;

    local procedure SetValuesFromFilter(var LocalFile: Record "ForNAV Local File")
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(LocalFile);
        if Evaluate(LocalFile.Alias, GetFilter(RecRef, LocalFile.FieldNo(Alias))) then;
        if Evaluate(LocalFile.Filename, GetFilter(RecRef, LocalFile.FieldNo(Filename))) then;
    end;

    local procedure GetFilter(var RecRef: RecordRef; FieldNo: Integer) FieldFilter: Text
    var
        FldRef: FieldRef;
        FilterGroup: integer;
    begin
        FldRef := RecRef.Field(FieldNo);
        while (FieldFilter = '') and (FilterGroup < 5) do begin
            RecRef.FilterGroup(FilterGroup);
            FieldFilter := FldRef.GetFilter();
            FilterGroup += 2;
        end;

        RecRef.FilterGroup(0);
    end;

    internal procedure Copy(var ToRecRef: RecordRef; FromVariant: Variant)
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

    [EventSubscriber(ObjectType::CodeUnit, Codeunit::"ForNAV TempTable", 'OnForNAVFillTemporaryTableForNAV', '', false, false)]
    local procedure OnForNAVFillTemporaryTableForNAV(ReportID: Integer; ChildDataItemId: Text; ParentRecRef: RecordRef; var TempRecRef: RecordRef)
    var
        TempLocalFile: Record "ForNAV Local File" temporary;
        Args: Record "ForNAV Local File";
        RecordRefLibrary: Codeunit "ForNAV RecordRef Library";
        LineRec: RecordRef;
    begin
        if TempRecRef.Number <> Database::"ForNAV Local File" then
            exit;

        TempRecRef.SetTable(TempLocalFile);

        FillLocalFiles(TempLocalFile, ParentRecRef);
        Copy(TempRecRef, TempLocalFile);
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeFillLocalFiles(var LocalFile: Record "ForNAV Local File"; SourceRec: Variant; var Handled: Boolean)
    begin
    end;
}