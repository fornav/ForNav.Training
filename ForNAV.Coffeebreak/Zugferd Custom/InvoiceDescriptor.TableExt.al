tableextension 50100 "PTE InvoiceDescriptor" extends "ForNAV InvoiceDescriptor"
{
    fields
    {
        /// <summary>
        /// A textual value used to establish a link between the payment and the invoice, issued by the seller.
        /// </summary>
        field(50100; "PTE New Payment Reference"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'NewPaymentReference', Locked = true;
        }
    }
}