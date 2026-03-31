codeunit 50101 "PTE Price List"
{
    [EventSubscriber(ObjectType::CodeUnit, Codeunit::"ForNAV TempTable", OnFillTemporaryTable, '', false, false)]
    local procedure OnForNAVFillTemporaryTableForNAV(ReportID: Integer; ChildDataItemId: Text; ParentRecRef: RecordRef; var TempRecRef: RecordRef; var IsHandled: Boolean)
    var
        TempPriceList: Record "PTE Price List" temporary;
    begin
        if TempRecRef.Number <> Database::"PTE Price List" then
            exit;

        TempRecRef.SetTable(TempPriceList, true);
        TempPriceList.LoadFromQuery();
        IsHandled := true;
    end;
}