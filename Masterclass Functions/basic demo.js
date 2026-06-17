function formatQuantity(quantity, unitOfMeasure) {
    return quantity.toFixed(2) + ' ' + unitOfMeasure;
}

console.log(formatQuantity(5.5, 'BOX'));
console.log(formatQuantity(12, 'PCS'));
