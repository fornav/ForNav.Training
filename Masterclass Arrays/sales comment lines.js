// Line OnPreDataItem
var comments = []

// Line OnAfterGetRecord
// Clear the array
comments = []

// Get the first comment line
if (SalesCommentLine.FieldExtensions.Comment.HasValue) {
    comments.push(SalesCommentLine.Comment)
}

// Get the next comment lines
while (SalesCommentLine.Next()) {
    comments.push(SalesCommentLine.Comment)
}

// Text Box Source Expression
// Join the entries in the comments array to a single text separated by a neline character
comments.join('\n')