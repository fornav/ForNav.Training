pageextension 70630 "ForNAV TR Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("ForNAV TR My Field"; Rec."ForNAV TR My Field")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies some text to display on your ForNAV reports.';
            }
        }
    }
}