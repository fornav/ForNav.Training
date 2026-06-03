console.clear()
let items = ['a', 'd']

items.push('')
items.push('c')

console.log(items.sort().join('\n'))
console.log('------------')
console.log(items.filter(item => item !== '').sort().join('\n'))