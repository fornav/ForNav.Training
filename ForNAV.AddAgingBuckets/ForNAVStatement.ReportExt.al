reportextension 50100 "PTE ForNAV Statement" extends "ForNAV Statement"
{
    requestpage
    {
        layout
        {
            addlast("Aging Band")
            {
                field(PTEColumnCount; Args."Column Count")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Column Count';
                }
            }
        }
    }
}