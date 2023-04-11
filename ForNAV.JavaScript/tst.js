function getText() {
    let result = ''
    fetch('https://raw.githubusercontent.com/fornav/ForNav.Training/master/ForNAV.JavaScript/Export%2Cjs')
        .then(r => r.text())
        .then(t => result += t )
    // read text from URL location
    // var request = new XMLHttpRequest();
    // request.open('GET', 'https://raw.githubusercontent.com/fornav/ForNav.Training/master/ForNAV.JavaScript/Export%2Cjs', true);
    // request.send(null);
    // request.onreadystatechange = function () {
    //     if (request.readyState === 4 && request.status === 200) {
    //         var type = request.getResponseHeader('Content-Type');
    //         if (type.indexOf("text") !== 1) {
    //             return request.responseText;
    //         }
    //     }
    // }
    return result
}

var code = getText()

console.log(code)