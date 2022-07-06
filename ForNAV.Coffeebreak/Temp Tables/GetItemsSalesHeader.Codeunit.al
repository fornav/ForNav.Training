codeunit 50100 "PTE Get Items SalesHeader"
{
    [EventSubscriber(ObjectType::CodeUnit, Codeunit::"ForNAV TempTable", 'OnFillTemporaryTable', '', false, false)]
    local procedure OnForNAVFillTemporaryTableForNAV(ReportID: Integer; ChildDataItemId: Text; ParentRecRef: RecordRef; var TempRecRef: RecordRef; var IsHandled: Boolean)
    var
        TempItemTotals: Record "PTE Item Totals" temporary;
        SalesHeader: Record "Sales Header";
    begin
        if IsHandled or (TempRecRef.Number <> Database::"PTE Item Totals") or (ParentRecRef.Number <> Database::"Sales Header") then
            exit;

        ParentRecRef.SetTable(SalesHeader);
        TempRecRef.SetTable(TempItemTotals);

        TempItemTotals.GetFromSalesHeader(SalesHeader);

        TempRecRef.Copy(TempItemTotals, true);
        IsHandled := true;
    end;
}