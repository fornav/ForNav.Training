// VATAmountLine OnPreDataItem
var vatLines = []

// VATAmountLine OnAfterGetRecord
var vatLine = {
    vatIdentifier : VATAmountLine.VATIdentifier,
    vatPct : VATAmountLine.VATPct,
    lineAmount : VATAmountLine.LineAmount,
    vatAmount : VATAmountLine.VATAmount,
    vatBase : VATAmountLine.VATBase
}

vatLines.push(vatLine)

// TextBoxes
vatLines.map(vatLine => vatLine.vatIdentifier).join('\n')

vatLines.map(vatLine => vatLine.vatPct).join('\n')

vatLines.map(vatLine => CurrReport.DotNetFormat(vatLine.lineAmount, '#,0.00')).join('\n')
vatLines.map(vatLine => vatLine.lineAmount).reduce((total, value) => total + value, 0)

vatLines.map(vatLine => CurrReport.DotNetFormat(vatLine.vatAmount, '#,0.00')).join('\n')
vatLines.map(vatLine => vatLine.vatAmount).reduce((total, value) => total + value, 0)

vatLines.map(vatLine => CurrReport.DotNetFormat(vatLine.vatBase, '#,0.00')).join('\n')
vatLines.map(vatLine => vatLine.vatBase).reduce((total, value) => total + value, 0)