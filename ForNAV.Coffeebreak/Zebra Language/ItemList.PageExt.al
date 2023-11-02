// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 "PTE Item List" extends "Item List"
{
    actions
    {
        addlast(reporting)
        {
            action(PTEPrintLabel)
            {
                Image = BarCode;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Print Zebra Label';

                trigger OnAction()
                var
                    ZebraPrint: Codeunit "PTE Zebra Print";
                    ZebraLayout: Text;
                begin
                    ZebraLayout := ZebraPrint.GetLayoutFromFileStorage('ITEMLABEL', 'ZEBRA');
                    ZebraPrint.ReplacePlaceholders(Rec, ZebraLayout);
                    ZebraPrint.PrintLayout('Item Label', 'Zebra Demo', ZebraLayout);
                end;
            }
        }
    }
}