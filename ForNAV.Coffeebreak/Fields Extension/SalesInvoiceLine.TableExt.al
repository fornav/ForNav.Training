tableextension 50103 "PTE Sales Invoice Line" extends "Sales Invoice Line"
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