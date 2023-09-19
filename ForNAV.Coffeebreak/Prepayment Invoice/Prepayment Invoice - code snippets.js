// Line DataItem - OnPreDataItem
var amt = 0;
var amtPpt = 0;
var pptLine = false;
var hasPpt = false;


// Line - OnAfterGetRecord
pptLine = Line.Amount < 0 && Line.Type == Line.FieldOptions.Type.G_LAccount;

if (!pptLine) {
    amt += Line.Amount;
} else {
    hasPpt = true;
    amtPpt += Line.Amount;
}

// Text box
    // Source output
Header.FieldLookups.CurrencyCode + ' ' + amtPpt + ' (excl. VAT) of this invoice has been prepaid.'

    //ShowOutput
hasPpt

    // OnPrint
CurrControl.BackColor = 'MistyRose'