var massArray = ['IN3350682', 1, 'DDK500', 1.62, 1096, 1775.52, 'IN3350682', 6, 'DDK500', 1.62, 41, 66.42, 'IN3350682', 11, 'DDK500', 1.62, 65, 105.30]

//split array by row

var newArr = chunk(massArray, 6)
console.log(newArr);


//compare the two and see if the invoice matches
var newList = [];
for(var i = 0; i < newArr.length-1; i++){
    if(newArr[i][0] == newArr[i+1][0] && newArr[i][2] == newArr[i+1][2]){
        //might make sense to do another loop to store multipe invoices and breaks out if not the same.
        var summedInvoice = joinTheSame(newArr[i], newArr[i+1])
        newList.push(summedInvoice);
        newList[i] = summedInvoice;
        console.log(newList);
    } else {
        newList.push(newArr[i+1])
        console.log(newList);
    }
}


function chunk(array, length) {
    let result = [];
    for (let i = 0; i < array.length / length; i++) {
        result.push(array.slice(i * length, i * length + length));
    }
    return result;
}

function joinTheSame(arr1, arr2){
    console.log(arr1, arr2);
    {
        var consolidated = [arr1[0], arr1[2], arr1[3]];
        consolidated.push(arr1[4] + arr2[4]);
        consolidated.push(arr1[5] + arr2[5])
    }
    return consolidated;
}