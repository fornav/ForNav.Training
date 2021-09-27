page 63000 "PTE Vendor Portals"
{
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "PTE Vendor Portal";
    Caption = 'Vendor Portals';

    layout
    {
        area(Content)
        {
            repeater(RepeaterGroup)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}