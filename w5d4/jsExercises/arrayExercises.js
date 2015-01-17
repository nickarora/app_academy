/* Array Exercises */

Array.prototype.include = function(target){
  for(var i = 0; i < this.length; i++){
    if (target === this[i]) {
      return true;
    }
  }

  return false;
};

var initMatrix = function(rows, cols){
  matrix = []

  for(var i = 0; i < rows; i++){
    var row = [];

    for(var j = 0; j < cols; j++){
      row.push(null);
    }

    matrix.push(row);
  }

  return matrix;
};

Array.prototype.uniq = function() {
  seen = [];

  for(var i = 0; i < this.length; i++){
    if (!seen.include(this[i])){
      seen.push(this[i]);
    }
  }

  return seen;
};

Array.prototype.twoSum = function() {

  pairs = [];

  for(var i = 0; i < this.length - 1; i++){
    for(var j = i + 1; j < this.length; j++){
      if (this[i] + this[j] == 0){
        pairs.push([i, j]);
      }
    }
  }

  return pairs;
};

Array.prototype.transpose = function() {

  transposed = initMatrix(this.length, this[0].length);

  for(var row = 0; row < this.length; row++){
    for(var column = 0; column < this.length; column++){
      transposed[row][column] = this[column][row];
    }
  }

  return transposed;
};
