reportextension 50100 "PTE ForNAV Customer - List" extends "ForNAV Customer - List"
{
    dataset
    {
        add(List)
        {
            column(PTEPrintlogo; PTEPrintlogo) { }
        }
    }

    requestpage
    {
        layout
        {
            addlast(Options)
            {
                field(PTEPrintlogo; PTEPrintlogo)
                {
                    Caption = 'Print Logo';
                    ToolTip = 'Specifies if the logo is printed';
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        // PTEPrintlogo := true;
    end;

    var
        [InDataSet]
        PTEPrintlogo: Boolean;
}