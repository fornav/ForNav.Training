let items = []
let result

function itemMap(item) {
    return item.no + '- ' + item.description;
}

items.push({
    no: '10',
    description: 'no 10'
})
items.push({
    no: '20',
    description: 'no 20'
})

// result = items.join('\n')
// result = items.map(itemMap).join('\n')
result = items.map(item => item.no + ': ' + item.description).join('\n')
// result = JSON.stringify(items)
console.log(result)