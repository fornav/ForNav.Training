// Header OnPreDataItem
var items = []

// Header OnAfterGetRecord
items = []

// Line OnAfterGetRecord
var searchIndex
searchIndex = items.findIndex(
    (item) => item.no == Line.No && item.type == Line.Type);

if (searchIndex == -1) {
    var item = {
        no: Line.No,
        type: Line.Type,
        quantity: Line.Quantity,
        description: Line.Description
    }
    items.push(item);
} else {
    items[searchIndex].quantity += Line.Quantity
}

// TextBox
items.map(item => item.Description + ': ' + item.quantity).join('\n')