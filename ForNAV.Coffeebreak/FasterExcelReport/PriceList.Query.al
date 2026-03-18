query 50100 "PTE Price List"
{
    QueryType = Normal;

    elements
    {
        dataitem(SalesPrice; "Price List Line")
        {
            column(PriceListCode; "Price List Code") { }
            column(ProductNo; "Product No.") { }
            column(UnitPrice; "Unit Price") { }
            column(Currency; "Currency Code") { }
            dataitem(Item; Item)
            {
                DataItemLink = "No." = SalesPrice."Product No.";
                SqlJoinType = LeftOuterJoin;
                column(Name; Description) { }
                column(Inventory; Inventory) { }
                column(BaseUnitOfMeasure; "Base Unit of Measure") { }
                dataitem(SalesLine; "Sales Line")
                {
                    DataItemLink = "No." = SalesPrice."Product No.";
                    SqlJoinType = LeftOuterJoin;
                    column(SalesLineDocumentType; "Document Type") { }
                    column(SalesLineQuantity; Quantity)
                    {
                        Method = Sum;
                    }
                }
            }
        }
    }
}
// https://bc-test/BC/?query=50100