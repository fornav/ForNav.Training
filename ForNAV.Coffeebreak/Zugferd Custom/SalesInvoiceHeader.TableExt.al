tableextension 50102 "PTE Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "PTE New Payment Reference"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'NewPaymentReference', Locked = true;
        }
    }
}