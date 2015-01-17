var range = function(start, end){
  // base case
  if (start == end){
    return [end];
  }

  var arr = [start];
  return arr.concat(range(start+1, end));
};

var sumArray = function(arr){
  //base case
  if (arr.length == 1){
    return arr[0];
  }

  var first = arr[0];

  return first + sumArray(arr.slice(1));
};

var power = function(base, exp) {
  if (exp == 0){
    return 1;
  }

  return base * power(base, exp - 1);
}

var fibonacci = function(n) {
  if (n == 0) {
    return [];
  }
  if (n == 1) {
    return [0];
  }
  if (n == 2) {
    return [0, 1];
  }

  var prev = fibonacci(n - 1);
  var next = [prev[prev.length - 1] + prev[prev.length - 2]];

  return prev.concat(next);
}

var binarySearch = function(arr, target) {

  var middle_index = Math.floor(arr.length / 2);
  var middle = arr[middle_index];
  var left = arr.slice(0, middle_index);
  var right = arr.slice(middle_index + 1, arr.length);
  var new_idx = 0;
  if (arr.length <= 1 && middle != target){
    return false;
  }

  if ( middle == target ) {
    return middle_index;
  } else if ( target < middle) {
    var new_idx = binarySearch(left, target);
    if (!(new_idx === false)){
      return new_idx;
    } else {
      return false;
    }
  } else {
    var new_idx = binarySearch(right, target);
    if (!(new_idx === false)) {
      return 1 + middle_index + new_idx;
    } else {
      return false;
    }
  }
}

var smallestArray = function(arrays) {

  var smallestCount = arrays[0].length;
  var bestArray = arrays[0];

  for (var i = 1; i < arrays.length; i++) {
    if (arrays[i].length < smallestCount ){
      smallestCount = arrays[i].length;
      bestArray = arrays[i];
    }
  }

  return bestArray;
}

var makeChange = function(target, coins) {
  solutions = [];
  var possibleCombos = [];

  if (target === 0) {
    return [];
  }

  for (var i = 0; i < coins.length; i++){

    if (target >= coins[i]){
      usableCoinFound = true;
      var recurse = makeChange(target - coins[i], coins);
      var newCombo = [coins[i]].concat(recurse);
      possibleCombos.push(newCombo);
    }

  }

  return smallestArray(possibleCombos);
}

var mergeSort = function(arr) {

  if (arr.length === 1) {
    return arr;
  }

  var middle_index = Math.floor(arr.length / 2);
  var left = arr.slice(0, middle_index);
  var right = arr.slice(middle_index, arr.length);

  return mergeArrays(mergeSort(left), mergeSort(right));
};

// Takes two sorted arrays and merges them together
var mergeArrays = function(arr1, arr2) {
  var mergedArray = [];

  while (arr1.length > 0 && arr2.length > 0){
    if (arr1[0] >= arr2[0]) {
      mergedArray.push(arr2.shift());
    } else {
      mergedArray.push(arr1.shift());
    }
  }

  return mergedArray.concat(arr1).concat(arr2);
};

var subsets = function(arr) {
  if (arr.length <= 0) {
    return [[]];
  }

  var subs = subsets(arr.slice(0, arr.length - 1));

  newSubs = [];

  for (var i = 0; i < subs.length; i++) {
    newSubs.push(subs[i].concat([arr[arr.length - 1]]));
  }

  return subs.concat(newSubs);
}
