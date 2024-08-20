pageextension 50101 "PTE Posted Sales Invoice" extends "Posted Sales Invoice"
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