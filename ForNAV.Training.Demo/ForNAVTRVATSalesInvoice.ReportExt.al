reportextension 70630 "ForNAVTR VAT Sales Invoice" extends "ForNAV VAT Sales Invoice"
{
    dataset
    {
        add(Header)
        {
            column(ShowItemSummary; ShowItemSummary) { }
        }
    }

    requestpage
    {
        layout
        {
            addlast(Options)
            {
                field(ShowItemSummary; ShowItemSummary)
                {
                    ApplicationArea = All;
                    Caption = 'Show Item Summary';
                    ToolTip = 'Shows the summary of all items at the top of the report';
                }
            }
        }
    }

    rendering
    {
        // layout(LayoutName)
        // {
        //     Type = RDLC;
        //     LayoutFile = 'mylayout.rdl';
        // }
    }

    var
        ShowItemSummary: Boolean;
}