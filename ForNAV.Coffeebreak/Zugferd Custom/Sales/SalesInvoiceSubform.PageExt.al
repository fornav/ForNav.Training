pageextension 50101 "PTE Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("PTE E-Inv. Description"; Rec."PTE E-Inv. Description")
            {
                ApplicationArea = All;
                Caption = 'E-invoice Description';
                ToolTip = 'A textual value used to describe the invoice, issued by the seller.';
            }
        }
    }
}