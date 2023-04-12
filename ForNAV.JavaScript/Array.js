let items = []

// items.push('a')
// items.push('b')
// items.push('c')

items.push({
    no: '10',
    description: 'no 10'
})
items.push({
    no: '20',
    description: 'no 20'
})

console.log(items.map(item => item.description).join('\n'))

