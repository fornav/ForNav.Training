pageextension 70631 "PageExtension56789" extends "Customer List"
{
    actions
    {

        addlast(Reporting)
        {
            action("PTE My List")
            {
                Caption = 'Run My List 2';
                Image = "PrintCover";
                Promoted = True;
                PromotedCategory = "Report";
                ApplicationArea = All;
                trigger OnAction()
                var
                    reportRec: Record "Customer";
                begin
                    reportRec.CopyFilters(Rec);
                    Report.Run(Report::"PTE My List 2", true, false, reportRec);
                end;
            }
        }

    }
}
