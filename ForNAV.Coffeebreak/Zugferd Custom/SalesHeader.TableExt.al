tableextension 50101 "PTE Sales Header" extends "Sales Header"
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