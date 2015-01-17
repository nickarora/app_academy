Array.prototype.uniq = function() {
  var seen = [];
  this.forEach(function(el) {
    if (seen.indexOf(el) === -1) {
      seen.push(el);
    }
  });
  return seen;
}

Array.prototype.transpose = function() {
  var transposed = [[null, null, null], 
                    [null, null, null], 
                    [null, null, null]];
  for (var row = 0; row < 3; row++) {
    for (var col = 0; col < 3; col++) {
      transposed[col][row] = this[row][col];
    }
  }
  return transposed;
}

function Board() {
  this.grid = [[null, null, null], 
               [null, null, null], 
               [null, null, null]];
  this.winner = null;
}

Board.prototype.won = function() {
  var that = this;

  var result = false;

  var diag1 = [];
  var diag2 = [];
  for (var i = 0; i < 3; i++) {
    diag1.push(this.grid[i][i]);
    diag2.push(this.grid[i][ Math.abs(2-i) ]);
  }

  
  var check = function(row) {
    if (row[0] && row.uniq().length === 1) {
      that.winner = row[0];
      result = true;
    }
  };

  // check rows
  this.grid.forEach(function(row) {
    check(row);
  });

  // checks cols
  this.grid.transpose().forEach(function(row) {
    check(row);
  });

  check(diag1);

  check(diag2);

  // check if draw
  var nullCount = 0;
  for(var row=0; row < 3; row++){
    nullCount += this.grid[row].indexOf(null);
  }
  if (nullCount === -3) {
    result = true;
  }

  return result;
};

Board.prototype.getAvailableMoves = function(){

  var moves = [];
  for(var row=0; row < 3; row++){
    for(var col=0; col < 3; col++){
      if (this.grid[row][col] == null){
        moves.push([col, row]);
      }
    }
  }

  return moves;
}

Board.prototype.placeMark = function(pos, mark) {
  var x = pos[0];
  var y = pos[1];

  if (this.empty(pos)) {
    this.grid[y][x] = mark;
    return true;
  }
  return false;
};

Board.prototype.empty = function(pos) {
  var x = pos[0];
  var y = pos[1];

  if (this.grid[y][x] == null ) {
      return true;
  }

  return false;
};

Board.prototype.deleteMark = function(pos) {
  var x = pos[0];
  var y = pos[1];

  this.grid[y][x] = null;
};

Board.prototype.display = function(){

  for( var row = 0; row < 3; row++ ) {
    for( var col = 0; col < 3; col++ ) {
      var xStr = col.toString();
      var yStr = row.toString();
      var mark = (this.grid[row][col] == null ? " " : this.grid[row][col]); 
      document.getElementById(xStr + yStr).innerHTML=mark;
    }
  }

};
