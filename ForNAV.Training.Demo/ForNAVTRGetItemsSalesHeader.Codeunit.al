codeunit 70630 "ForNAVTR Get Items SalesHeader"
{
    [EventSubscriber(ObjectType::CodeUnit, Codeunit::"ForNAV TempTable", 'OnFillTemporaryTable', '', false, false)]
    local procedure OnForNAVFillTemporaryTableForNAV(ReportID: Integer; ChildDataItemId: Text; ParentRecRef: RecordRef; var TempRecRef: RecordRef; var IsHandled: Boolean)
    var
        Item: Record Item;
        TempItem: Record Item temporary;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        if IsHandled then
            exit;

        if TempRecRef.Number <> Database::Item then
            exit;

        if ParentRecRef.Number <> Database::"Sales Invoice Header" then
            exit;

        ParentRecRef.SetTable(SalesInvoiceHeader);
        TempRecRef.SetTable(TempItem);

        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
        if SalesInvoiceLine.FindSet() then
            repeat
                Item.Get(SalesInvoiceLine."No.");
                TempItem := Item;
                if TempItem.Insert() then;
            until SalesInvoiceLine.Next() = 0;

        TempRecRef.Copy(TempItem, true);
        IsHandled := true;
    end;
}