codeunit 50100 "PTE Create CB PriceList"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        PriceListHeader: Record "Price List Header";
        PriceListLine: Record "Price List Line";
        Item: Record Item;
        LineNo: Integer;
    begin
        // Create or recreate the price list header
        if PriceListHeader.Get('COFFEEBREAK') then
            // PriceListHeader.Delete(true);
        exit;

        PriceListHeader.Init();
        PriceListHeader."Price Type" := Enum::"Price Type"::Sale;
        PriceListHeader."Source Group" := PriceListHeader."Source Group"::Customer;
        PriceListHeader.Code := 'COFFEEBREAK';
        PriceListHeader.Description := 'Coffeebreak Price List';
        PriceListHeader.Status := Enum::"Price Status"::Draft;
        PriceListHeader."Allow Updating Defaults" := true;
        PriceListHeader.Insert(true);

        // Add lines for the first 25 inventory items
        Item.SetRange(Type, Item.Type::Inventory);
        Item.SetRange(Blocked, false);
        Item.SetRange("Inventory Posting Group", 'RESALE');
        if not Item.FindSet() then
            exit;

        LineNo := 10000;
        repeat
            PriceListLine.Init();
            PriceListLine."Price List Code" := PriceListHeader.Code;
            PriceListLine."Line No." := LineNo;
            PriceListLine."Price Type" := PriceListHeader."Price Type";
            PriceListLine.Validate("Asset Type", Enum::"Price Asset Type"::Item);
            PriceListLine.Validate("Asset No.", Item."No.");
            PriceListLine."Unit Price" := Item."Unit Price";
            PriceListLine."Unit of Measure Code" := Item."Sales Unit of Measure";
            PriceListLine.Status := Enum::"Price Status"::Draft;
            PriceListLine.Insert(true);

            LineNo += 10000;
        until (Item.Next() = 0) or (LineNo > 250000);

        Message('Price list COFFEEBREAK created with %1 lines.', LineNo / 10000 - 1);
    end;
}
