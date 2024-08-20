tableextension 50103 "PTE Sales Invoice Line" extends "Sales Invoice Line"
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