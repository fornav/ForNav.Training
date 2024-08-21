pageextension 50100 "PTE Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("PTE New Payment Reference"; Rec."PTE New Payment Reference")
            {
                ApplicationArea = All;
                Caption = 'NewPaymentReference';
                ToolTip = 'A textual value used to establish a link between the payment and the invoice, issued by the seller.';
            }
        }
    }
}