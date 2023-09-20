// Line DataItem - OnPreDataItem
var amount = 0;
var amountPrepayment = 0;
var prepaymentLine = false;
var hasPrepayment = false;


// Line - OnAfterGetRecord
prepaymentLine = Line.Amount < 0 && Line.Type == Line.FieldOptions.Type.G_LAccount;

if (prepaymentLine) {
    hasPrepayment = true;
    amountPrepayment += Line.Amount;
} else {
    amount += Line.Amount;
}

// Text box
    // Source output
Header.FieldLookups.CurrencyCode + ' ' + -amountPrepayment + ' (excl. VAT) of this invoice has been prepaid.'

    //ShowOutput
hasPrepayment

    // OnPrint
CurrControl.BackColor = 'MistyRose'