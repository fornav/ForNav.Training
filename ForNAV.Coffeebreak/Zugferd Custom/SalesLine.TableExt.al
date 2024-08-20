tableextension 50101 "PTE Sales Line" extends "Sales Line"
{
    fields
    {
        field(50100; "PTE E-Inv. Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'E-invoice Description', Locked = true;
        }
    }
}