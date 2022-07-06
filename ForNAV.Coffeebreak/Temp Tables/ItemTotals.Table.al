table 50100 "PTE Item Totals"
{
    DataClassification = SystemMetadata;
    TableType = Temporary;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Item No.';

        }
        field(2; Quantity; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Quantity';
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    procedure GetFromSalesHeader(SalesHeader: Record "Sales Header");
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then
            repeat
                if Get(SalesLine."No.") then begin
                    Quantity += SalesLine.Quantity;
                    Modify();
                end else begin
                    "Item No." := SalesLine."No.";
                    Quantity := SalesLine.Quantity;
                    Insert();
                end;
            until SalesLine.Next() = 0;
    end;
}