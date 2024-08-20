codeunit 50100 "PTE EInvoice Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ForNAV eDocument Interface", OnAfterDocument2InvoiceDescriptor, '', false, false)]
    local procedure OnAfterDocument2InvoiceDescriptor(var InvoiceDescriptor: Record "ForNAV InvoiceDescriptor")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        case InvoiceDescriptor.Type of
            InvoiceDescriptor.Type::Invoice:
                begin
                    SalesInvoiceHeader.Get(InvoiceDescriptor.InvoiceNo);
                    InvoiceDescriptor."PTE New Payment Reference" := SalesInvoiceHeader."PTE New Payment Reference";
                    InvoiceDescriptor.Modify();
                end;
        end;
    end;
}