var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var addNumbers = function(sum, numsLeft, completionCallback){
  if (numsLeft > 0) {
    reader.question("Give me a number!", function(numString){
      var num = parseInt(numString);
      sum += num;
      console.log("sum is:" + sum);
      addNumbers(sum, --numsLeft, completionCallback);
    });
  } else {
    completionCallback(sum);
    reader.close();
  }
};

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
