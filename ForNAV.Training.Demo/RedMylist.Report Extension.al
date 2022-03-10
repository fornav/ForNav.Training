pageextension 70631 "Red Customer List" extends "Customer List"
{
    actions
    {

        addlast(Reporting)
        {
            action("Red My list")
            {
                Caption = 'Run My List';
                Image = "PrintCover";
                Promoted = True;
                PromotedCategory = "Report";
                ApplicationArea = All;
                trigger OnAction()
                var
                    reportRec: Record "Customer";
                begin
                    reportRec.CopyFilters(Rec);
                    Report.Run(Report::"Red My list1", true, false, reportRec);
                end;
            }
        }

    }
}
