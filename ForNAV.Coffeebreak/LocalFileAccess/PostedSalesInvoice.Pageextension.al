pageextension 50150 "ForNAV Posted Sales Invoice" extends "Posted Sales Invoice"
{
    actions
    {
        addafter(Print)
        {
            action(SaveLocalFile)
            {
                ApplicationArea = All;
                Caption = 'Save Local File';
                ToolTip = 'Save the report to a local file.';
                Image = Export;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    FileService: Codeunit "ForNAV File Service";
                    TempBlob: Codeunit "Temp Blob";
                    RecRef: RecordRef;
                    FileInStream: InStream;
                    FileOutStream: OutStream;
                begin
                    SalesInvoiceHeader := Rec;
                    SalesInvoiceHeader.SetRecFilter();
                    RecRef.GetTable(SalesInvoiceHeader);
                    TempBlob.CreateOutStream(FileOutStream);
                    Report.SaveAs(Report::"ForNAV VAT Sales Invoice", '', ReportFormat::Pdf, FileOutStream, RecRef);
                    TempBlob.CreateInStream(FileInStream);
                    FileService.WriteFromStream(StrSubstNo('COFFEEBREAK:\%1.pdf', SalesInvoiceHeader."No."), FileInStream);
                end;
            }
        }
    }
}