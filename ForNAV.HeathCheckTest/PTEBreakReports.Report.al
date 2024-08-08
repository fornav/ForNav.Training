report 50101 "PTE Break Reports"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(BreakStuff; BreakStuff)
                    {
                        ApplicationArea = All;
                        Caption = 'Break stuff';
                    }
                }
            }
        }
    }
    var
        BreakStuff: Boolean;

    trigger OnPreReport()
    var
        Install: Codeunit "PTE Install";
    begin
        if BreakStuff then
            Install.BreakStuff();
    end;
}