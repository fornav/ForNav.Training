codeunit 50100 "PTE EInvoice Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ForNAV eDocument Interface", OnAfterDocument2InvoiceDescriptor, '', false, false)]
    local procedure OnAfterDocument2InvoiceDescriptor(var InvoiceDescriptor: Record "ForNAV InvoiceDescriptor")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ResponsibilityCenter: Record "Responsibility Center";
        Seller: Record "ForNAV Party";
        SalesInvoiceLine: Record "Sales Invoice Line";
        TradeLineItem: Record "ForNAV TradeLineItem";
        LineNo: Integer;
    begin
        case InvoiceDescriptor.Type of
            InvoiceDescriptor.Type::Invoice:
                begin
                    SalesInvoiceHeader.Get(InvoiceDescriptor.InvoiceNo);
                    InvoiceDescriptor.PaymentReference := SalesInvoiceHeader."PTE New Payment Reference";

                    if ResponsibilityCenter.Get(SalesInvoiceHeader."Responsibility Center") then begin
                        InvoiceDescriptor.FindFirstSeller(Seller);
                        Seller.Name := ResponsibilityCenter.Name;
                        Seller.Modify();
                    end;

                    if InvoiceDescriptor.FindFirstTradeLineItems(TradeLineItem) then
                        repeat
                            Evaluate(LineNo, TradeLineItem.LineID);
                            SalesInvoiceLine.Get(SalesInvoiceHeader."No.", LineNo);
                            if SalesInvoiceLine."PTE E-Inv. Description" <> '' then begin
                                TradeLineItem.Description := SalesInvoiceLine."PTE E-Inv. Description";
                                TradeLineItem.Modify();
                            end;
                        until TradeLineItem.Next() = 0;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ForNAV eDocument Interface", OnDocument2InvoiceDescriptor, '', false, false)]
    local procedure OnDocument2InvoiceDescriptor(var InvoiceDescriptor: Record "ForNAV InvoiceDescriptor"; var eInvoice: Record "ForNAV eInvoice" temporary)
    begin
        case eInvoice."Document Type" of
            eInvoice."Document Type"::Invoice:
                RunYourOwnCodeHere(InvoiceDescriptor, eInvoice);
        end;
    end;
}