// Report OnPreReport script
function addDOM(content) {
    return (`<!DOCTYPE html>\
      <html>\
        <head>\
          <style>\
            #matrix {font-family: "Segoe UI"; font-size: 10px; border-collapse: collapse; margin: 0px 0px 0px 0px; }\
            .data {text-align: center; width: 50px; }\
            .caption {width: 50px; }\
          </style>\
        </head>\
        ${content}\
      </html>`
    )
}

function createTableHdr(headers) {
    let result = ''
    for (const header of headers) {
        result += `<th class=data>${header}</th>`
    }
    return result
}

function createTable(caption, headers, lines, columns) {
    let table = `<tr><th>${caption}</th>${createTableHdr(headers)}</tr>`

    for (const line of lines) {
        let row = `<td class=caption>${line}</td>`

        for (const header of headers) {
            const qty = columns.find((column) => column.size == header && column.color == line).quantity
            row += `<td class=data>${qty ? qty : ''}</td>`
        }

        table += `<tr>${row}</tr>`
    }

    return `<table id=matrix>${table}</table>`
}

// Table text box source expression
addDOM(createTable('Color/Size', hdrTitles, lineTitles, quantities))