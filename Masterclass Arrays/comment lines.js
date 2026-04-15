// Line OnPreDataItem
var comments = []

// Line OnAfterGetRecord
comments = []

if (SalesLine.FieldExtensions.Description.HasValue) {
    comments.push(SalesLine.Description)
}

while (SalesLine.Next()) {
    comments.push(SalesLine.Description)
}
