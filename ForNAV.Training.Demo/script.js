// Add this to the OnPreReport trigger
var lastItem = '',
    hdrTitles = [],
    lineTitles = [],
    quantities = []

function addMatrixData() {
    if (lastItem != Line.No) {
        lastItem = Line.No
        quantities = []
    }

    const searchIndex = quantities.findIndex(
        (quantity) => quantity.color == ItemVariant.Description);

    if (searchIndex == -1) {
        quantities.push({
            color: ItemVariant.Description,
            quantity: Line.Quantity
        })
    } else {
        quantities[searchIndex].quantity += Line.Quantity
    }
}
    

function LineOnPreDataItem() {
    // Add this to the LineOnPreDataItem trigger
    var lastItem = '',
    quantities = []
}

function LineOnAfterGetRecord() {
    // Add this to the LineOnAfterGetRecord trigger
    addMatrixData()
}

function ColumnHeaderSourceExpression() {
    // Add this to the ColumnHeaderSourceExpression trigger. Increment for column 2, 3, n
    quantities.length > 0 ? quantities[0].color : ''
}

function CellSourceExpression() {
    // Add this to the CellSourceExpression trigger
    quantities.length > 0 ? quantities[0].quantity : ''
}