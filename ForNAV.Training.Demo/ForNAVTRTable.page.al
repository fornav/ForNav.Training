page 70630 "ForNAV TR Table"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ForNAV TR Table";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(CustomerNo; Rec.CustomerNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the relation to the customer table';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the description';
                }
            }
        }
    }
}