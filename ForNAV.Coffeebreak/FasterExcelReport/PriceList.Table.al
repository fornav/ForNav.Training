table 50100 "PTE Price List"
{
    DataClassification = CustomerContent;
    Caption = 'Price List';
    TableType = Temporary;

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; PriceListCode; Code[20])
        {
            Caption = 'Price List Code';
            TableRelation = "Price List Header";
        }
        field(3; ProductNo; Code[20])
        {
            Caption = 'Product No.';
            TableRelation = "Price List Line"."Product No." where("Price List Code" = field(PriceListCode));
        }
        field(4; UnitPrice; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(5; Currency; Code[10])
        {
            Caption = 'Currency Code';
        }
        field(6; Name; Text[100])
        {
            Caption = 'Description';
        }
        field(7; Inventory; Decimal)
        {
            Caption = 'Inventory';
        }
        field(8; BaseUnitOfMeasure; Code[10])
        {
            Caption = 'Base Unit of Measure';
        }
        field(9; SalesLineDocumentType; Text[250])
        {
            Caption = 'Sales Line Document Type';
        }
        field(10; SalesLineQuantity; Decimal)
        {
            Caption = 'Sales Line Quantity';
        }
    }

    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }

    procedure LoadFromQuery()
    var
        PriceListQuery: Query "PTE Price List";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.Get();
        Rec.DeleteAll();

        if GetFilter(PriceListCode) <> '' then
            PriceListQuery.SetFilter(PriceListCode, GetFilter(PriceListCode));
        if GetFilter(ProductNo) <> '' then
            PriceListQuery.SetFilter(ProductNo, GetFilter(ProductNo));
        if GetFilter(Currency) <> '' then
            PriceListQuery.SetFilter(Currency, GetFilter(Currency));
        if GetFilter(Name) <> '' then
            PriceListQuery.SetFilter(Name, GetFilter(Name));

        PriceListQuery.Open();
        while PriceListQuery.Read() do begin
            Rec.Init();
            Rec.EntryNo += 1;
            Rec.ProductNo := PriceListQuery.ProductNo;
            Rec.PriceListCode := PriceListQuery.PriceListCode;
            Rec.UnitPrice := PriceListQuery.UnitPrice;
            Rec.Currency := PriceListQuery.Currency;
            if Rec.Currency = '' then
                Rec.Currency := GeneralLedgerSetup."LCY Code";

            Rec.Name := PriceListQuery.Name;
            Rec.Inventory := PriceListQuery.Inventory;
            Rec.BaseUnitOfMeasure := PriceListQuery.BaseUnitOfMeasure;
            Rec.SalesLineQuantity := PriceListQuery.SalesLineQuantity;
            if Rec.SalesLineQuantity > 0 then
                Rec.SalesLineDocumentType := Format(PriceListQuery.SalesLineDocumentType);

            if (PriceListQuery.SalesLineDocumentType = PriceListQuery.SalesLineDocumentType::Order) or (PriceListQuery.SalesLineQuantity = 0) then
                Rec.Insert();
        end;
        PriceListQuery.Close();
        Rec.Reset();
    end;
}
