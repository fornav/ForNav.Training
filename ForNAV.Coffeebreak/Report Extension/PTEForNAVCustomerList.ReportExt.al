reportextension 50100 "PTE ForNAV Customer List" extends "ForNAV Customer - List"
{
    dataset
    {
        add(List)
        {
            column(PTEPrintLogo; PTEPrintLogo) { }
        }
    }

    requestpage
    {
        layout
        {
            addlast(Options)
            {
                field(PTEPrintLogo; PTEPrintLogo)
                {
                    Caption = 'Print Logo';
                    ToolTip = 'Specifies print logo';
                    ApplicationArea = All;
                }
            }
        }
        trigger OnOpenPage()
        begin
            PTEPrintLogo := true;
        end;
    }

    trigger OnPreReport()
    begin
        // PTEPrintLogo := false;
    end;

    var
        [InDataSet]
        PTEPrintLogo: Boolean;
}