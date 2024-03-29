#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50100 "PTE Invoice"
{
    WordLayout = './Layouts/PTEInvoice.docx';
    DefaultLayout = Word;

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_2; 2) { } // Autogenerated by ForNav - Do not delete
            column(ReportForNav_Header; ReportForNavWriteDataItem('Header', Header)) { }
            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(ReportForNavId_3; 3) { } // Autogenerated by ForNav - Do not delete
                column(ReportForNav_Line; ReportForNavWriteDataItem('Line', Line)) { }
                trigger OnPreDataItem();
                begin
                    Line.SetView(ReportForNav.OnPreDataItemView('Line', Line));
                end;

            }
            trigger OnPreDataItem();
            begin
                Header.SetView(ReportForNav.OnPreDataItemView('Header', Header));
            end;

        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
        }

    }

    trigger OnInitReport()
    begin
        ;
        ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin
        ;
        ReportsForNavPre;
        AppendPDF();
    end;

    local procedure AppendPDF()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        is: instream;
        os: outstream;
    begin
        TempBlob.CreateOutStream(os);
        TempBlob.CreateInStream(is);

        SalesInvoiceHeader.CopyFilters(Header);
        if not SalesInvoiceHeader.FindSet() then
            exit;

        CustLedgerEntry.SetRange("Customer No.", SalesInvoiceHeader."Sell-to Customer No.");
        if CustLedgerEntry.IsEmpty then
            exit;

        RecRef.GetTable(CustLedgerEntry);

        Report.SaveAs(Report::"ForNAV Customer Payments", '', ReportFormat::PDF, os, RecRef);

        if TempBlob.HasValue() then begin
            ReportForNav.SetAppendPdf('Header', is);
        end;
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        ReportForNav: Codeunit "ForNAV Report Management";
        ReportForNavTotalsCausedBy: Integer;
        ReportForNavInitialized: Boolean;
        ReportForNavShowOutput: Boolean;

    local procedure ReportsForNavInit()
    var
        id: Integer;
    begin
        Evaluate(id, CopyStr(CurrReport.ObjectId(false), StrPos(CurrReport.ObjectId(false), ' ') + 1));
        ReportForNav.OnInit(id);
    end;

    local procedure ReportsForNavPre()
    begin
    end;

    local procedure ReportForNavSetTotalsCausedBy(value: Integer)
    begin
        ReportForNavTotalsCausedBy := value;
    end;

    local procedure ReportForNavSetShowOutput(value: Boolean)
    begin
        ReportForNavShowOutput := value;
    end;

    local procedure ReportForNavInit(jsonObject: JsonObject)
    begin
        ReportForNav.Init(jsonObject, CurrReport.ObjectId);
    end;

    local procedure ReportForNavWriteDataItem(dataItemId: Text; rec: Variant): Text
    var
        values: Text;
        jsonObject: JsonObject;
        currLanguage: Integer;
    begin
        if not ReportForNavInitialized then begin
            ReportForNavInit(jsonObject);
            ReportForNavInitialized := true;
        end;

        case (dataItemId) of
            'Header':
                begin
                    currLanguage := GlobalLanguage;
                    GlobalLanguage := 1033;
                    jsonObject.Add('DataItem$Header$CurrentKey$Text', Header.CurrentKey);
                    GlobalLanguage := currLanguage;
                end;
        end;
        ReportForNav.AddDataItemValues(jsonObject, dataItemId, rec);
        jsonObject.WriteTo(values);
        exit(values);
    end;
    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
