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
// Demo the raw content of an array
JSON.stringify(items)
// items.sort((a, b) => a.description.localeCompare(b.description));
items.map(item => item.description + ': ' + item.quantity)
    .sort((a, b) => a.localeCompare(b))
    .join('\n')
