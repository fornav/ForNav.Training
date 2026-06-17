// OnPreReport
function formatQuantity(quantity, unitOfMeasure) {
    return CurrReport.DotNetFormat(quantity, "N2") + ' ' + unitOfMeasure;
}

// Quantity textbox
formatQuantity(Line.Quantity, Line.UnitOfMeasure)