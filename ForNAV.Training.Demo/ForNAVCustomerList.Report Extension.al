pageextension 70631 "FORNAV TR Customer List" extends "Customer List"
{
    actions
    {

        addlast(Reporting)
        {
            action("ForNAV Customer List")
            {
                Caption = 'ForNAV Customer List';
                Image = "PrintCover";
                Promoted = True;
                PromotedCategory = "Report";
                ApplicationArea = All;
                trigger OnAction()
                var
                    reportRec: Record "Customer";
                begin
                    reportRec.CopyFilters(Rec);
                    Report.Run(Report::"ForNAV TR Customer List", true, false, reportRec);
                end;
            }
        }

    }
}
