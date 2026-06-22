# KB: ForNAV E-Invoicing now passes temporary records — update your event subscribers

## What changed

The ForNAV E-invoicing module (bundled into **ForNAV Core Development e4** as of `app.json` version `8.2.0.0`) now calls `InvoiceDescriptor.FindFirstSeller(...)` and `InvoiceDescriptor.FindFirstTradeLineItems(...)` with **temporary** instances of `Record "ForNAV Party"` and `Record "ForNAV TradeLineItem"`.

In AL, a `var` record parameter must match the temporary-ness of the variable passed in at the call site. If your local variable is declared as a normal (non-temporary) record, calling these methods will fail at runtime (or compile time, depending on the signature) because the temporary record from the interface can't be bound to a non-temporary variable.

## The fix

Declare any local record variable that receives data from `FindFirstSeller`, `FindFirstTradeLineItems`, or similar `ForNAV eDocument Interface` methods as `Temporary`.

```al
var
    TempSeller: Record "ForNAV Party" Temporary;
    TempTradeLineItem: Record "ForNAV TradeLineItem" Temporary;
```

See the fix applied in `EinvoiceEvents.Codeunit.al`:

```al
if ResponsibilityCenter.Get(SalesInvoiceHeader."Responsibility Center") then begin
    InvoiceDescriptor.FindFirstSeller(TempSeller);
    TempSeller.Name := ResponsibilityCenter.Name;
    TempSeller.Modify();
end;

if InvoiceDescriptor.FindFirstTradeLineItems(TempTradeLineItem) then
    repeat
        Evaluate(LineNo, TempTradeLineItem.LineID);
        SalesInvoiceLine.Get(SalesInvoiceHeader."No.", LineNo);
        if SalesInvoiceLine."PTE E-Inv. Description" <> '' then begin
            TempTradeLineItem.Description := SalesInvoiceLine."PTE E-Inv. Description";
            TempTradeLineItem.Modify();
        end;
    until TempTradeLineItem.Next() = 0;
```

Renaming the variables (`Seller` → `TempSeller`, `TradeLineItem` → `TempTradeLineItem`) is not required, but it's good practice — it makes the temporary status of the record visible at every call site instead of being a surprise when you go looking for it.

## What to do in your own extensions

If you have an `OnAfterDocument2InvoiceDescriptor` (or similar) event subscriber on `Codeunit::"ForNAV eDocument Interface"` that declares its own `Record "ForNAV Party"` or `Record "ForNAV TradeLineItem"` (or any other record populated via the `InvoiceDescriptor.FindFirst...` methods):

1. Add the `Temporary` keyword to the variable declaration.
2. Recompile and re-test — `.Modify()` calls on these records only affect the in-memory descriptor that ForNAV sends onward; they are never written to the database.
3. Check any other event subscribers in your codebase that touch `ForNAV InvoiceDescriptor` sub-records for the same pattern.

## Why ForNAV did this

Making these buffer records temporary avoids accidental database writes from custom event subscribers and matches how the descriptor data is actually used — as an in-memory document being assembled for the e-invoice, not a persisted table.
