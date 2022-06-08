// Add this to the OnPreReport trigger
var lastItem = '',
    hdrTitles = [],
    lineTitles = [],
    quantities = []

function addMatrixData() {
    if (lastItem != Line.No) {
        hdrTitles = []
        lineTitles = []
        lastItem = Line.No
        quantities = []
    }

    let variantinfo = ItemVariant.Description.split(',')

    if (!hdrTitles.includes(variantinfo[0])) {
        hdrTitles.push(variantinfo[0])
    }

    if (!lineTitles.includes(variantinfo[1])) {
        lineTitles.push(variantinfo[1])
    }

    const searchIndex = quantities.findIndex(
        (quantity) => quantity.size == variantinfo[0] && quantity.color == variantinfo[1]);

    if (searchIndex == -1) {
        quantities.push({
            size: variantinfo[0],
            color: variantinfo[1],
            quantity: Line.Quantity
        })
    } else {
        quantities[searchIndex].quantity += Line.Quantity
    }
}

function LineOnPreDataItem() {
    // Add this to the LineOnPreDataItem trigger
    lastItem = ''
    hdrTitles = []
    lineTitles = []
    quantities = []
}

function LineOnAfterGetRecord() {
    // Add this to the LineOnAfterGetRecord trigger
    addMatrixData()
}

function ColumnHeaderSourceExpression() {
    // Add this to the ColumnHeaderSourceExpression trigger. Increment for column 2, 3, n
    hdrTitles.length > 0 ? hdrTitles[0] : ''
}

function RowHeaderSourceExpression() {
    // Add this to the RowHeaderSourceExpression trigger. Increment for row 2, 3, n
    lineTitles.length > 0 ? lineTitles[0] : ''
}

function RowShowOutput() {
    // Add this to the RowShowOutput trigger. Increment for row 2, 3, n
    lineTitles.length > 0
}

function CellSourceExpression() {
    // Add this to the CellSourceExpression trigger
    hdrTitles.length > 0 ? quantities.find((quantity) => quantity.size == hdrTitles[0] && quantity.color == lineTitles[0]).quantity : ''
}

