reportextension 50000 "PTE ForNAV VAT Sales Invoice" extends "ForNAV VAT Sales Invoice"
{
    dataset
    {
        add(Header)
        {
            column(PTECustomText; PTECustomText)
            {
                Caption = 'Custom Text';
            }
        }
    }
    requestpage
    {
        layout
        {
            addlast(Content)
            {
                field(PTECustomText; PTECustomText)
                {
                    ApplicationArea = All;
                    Caption = 'Custom Text';
                }
            }
        }
    }

    rendering
    {
        layout(ExtensionLayout)
        {
            Type = Custom;
            MimeType = 'FORNAV';
            LayoutFile = './Layouts/ForNAVVatSalesInvoice-ext.docx';
        }
    }

    var
        PTECustomText: Text;
}