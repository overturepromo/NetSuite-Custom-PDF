var massArray = ['IN3350682', 1, 'DDK500', 1.62, 1096, 1775.52, 'IN3350682', 6, 'DDK500', 1.62, 41, 66.42,]

//split array by row

var newArr = chunk(massArray, 6)


//compare the two and see if the invoice matches


function chunk(array, length) {
    let result = [];
    for (let i = 0; i < array.length / length; i++) {
        result.push(array.slice(i * length, i * length + length));
    }
    return result;
}

function joinTheSame(){
    if(newArr[0][0] == newArr[1][0] && newArr[0,2] == newArr[1,2]){
        console.log('match')
        var consolidated = [newArr[0][0], newArr[0][2], newArr[0][3]];
        consolidated.push(newArr[0][4] + newArr[1][4]);
        consolidated.push(newArr[0][5] + newArr[1][5])
    }
}