Array.prototype.bubbleSort = function(){

  sortedArray = this.clone();
  sorted = false;

  while (!sorted) {
    sorted = true;
    for(var i = 0; i < this.length - 1; i++){
      if (sortedArray[i] > sortedArray[i + 1]){
        sortedArray[i+1] = [sortedArray[i], sortedArray[i] = sortedArray[i+1]][0];
        sorted = false;
      }
    }
  }

  return sortedArray;
};

Array.prototype.clone = function() {
  return this.slice(0);
};

String.prototype.subStrings = function(){

  subStr = [];

  for(var i = 0; i < this.length; i++) {
    for(var j = i + 1; j <= this.length; j++) {
      subStr.push( this.slice(i,j) );
    }
  }

  return subStr;
};
