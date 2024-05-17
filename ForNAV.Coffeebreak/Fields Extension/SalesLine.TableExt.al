tableextension 50101 "PTE Sales Line" extends "Sales Line"
{
    fields
    {
        field(50100; "CoffeeBreakBarCode"; Text[6])
        {
            Caption = 'Coffee Break Bar Code';
            DataClassification = CustomerContent;
        }
    }

}