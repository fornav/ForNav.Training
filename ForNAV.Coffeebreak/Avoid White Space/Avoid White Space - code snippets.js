// OnPreDataItem - creating the array
var headerfields = []


// OnAfterGetRecord - emptying the array and filling it with captions and values
headerfields = []

if(Header.FieldExtensions.DocumentDate.HasValue) {
    headerfields.push({
        caption : Header.FieldCaptions.DocumentDate,
        value : CurrReport.DotNetFormat(Header.DocumentDate, 'dd-MM-yyyy')
    })
}
if(Header.FieldExtensions.SalespersonCode.HasValue) {
    headerfields.push({
        caption : Header.FieldCaptions.SalespersonCode,
        value : Header.SalespersonCode
    })
}
if(Header.FieldExtensions.DueDate.HasValue) {
    headerfields.push({
        caption : Header.FieldCaptions.DueDate,
        value : CurrReport.DotNetFormat(Header.DueDate, 'dd-MM-yyyy')
    })
}


// Stringify - show the contents of an array in a long string
JSON.stringify(headerfields)


// Making a list of captions
headerfields.map(field => field.caption).join('\n')


// Making a list of values
headerfields.map(field => field.value).join('\n')


// Using caption entries from the headerfields array in text boxes
headerfields.length > 0 ? headerfields[0].caption : ''

headerfields.length > 1 ? headerfields[1].caption : ''

headerfields.length > 2 ? headerfields[2].caption : ''


// Using value entries from the headerfields array in text boxes
headerfields.length > 0 ? headerfields[0].value : ''

headerfields.length > 1 ? headerfields[1].value : ''

headerfields.length > 2 ? headerfields[2].value : ''