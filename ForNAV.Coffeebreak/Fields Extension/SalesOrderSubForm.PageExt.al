pageextension 50101 "PTE Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Coffee Break Bar Code"; Rec."CoffeeBreakBarCode")
            {
                ApplicationArea = Basic;
                Caption = 'Coffee Break - Bar Code';
                ToolTip = 'The Bar Code field for the ForNAV Coffee Break mini-extension.';
            }
        }
    }

}