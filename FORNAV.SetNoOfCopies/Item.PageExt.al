pageextension 50100 "PTE Item List" extends "Item List"
{
    actions
    {
        addlast(Reports)
        {
            action(TestERVAPI)
            {
                ApplicationArea = All;
                Caption = 'FORNAV Item Label with copies';
                ToolTip = 'Runs the FORNAV Item Label with copies';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = BarCode;

                trigger OnAction()
                var
                    Item: Record Item;
                    ItemLabel: Report "ForNAV Item - Label";
                    RecRef: RecordRef;
                    ReqPageParams: Text;
                    NoOfCopies: Integer;
                begin
                    NoOfCopies := 2;
                    Item := Rec;
                    Item.SetRecFilter();
                    // ReqPageParams := Report.RunRequestPage(Report::"ForNAV Item - Label");
                    ReqPageParams := StrSubstNo('<?xml version="1.0" standalone="yes"?><ReportParameters name="ForNAV Item - Label" id="6188685"><Options><Field name="NoOfCopies">%1</Field></Options></ReportParameters>', NoOfCopies);
                    RecRef.GetTable(Item);
                    Report.Execute(Report::"ForNAV Item - Label", ReqPageParams, RecRef);
                end;
            }
        }
    }
}