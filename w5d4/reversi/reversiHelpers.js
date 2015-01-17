var initMatrix = function(rows, cols){
  matrix = []

  for(var i = 0; i < rows; i++){
    var row = [];

    for(var j = 0; j < cols; j++){
      row.push(null);
    }

    matrix.push(row);
  }

  matrix[3][3] = new Piece("white");
  matrix[3][4] = new Piece("black");
  matrix[4][3] = new Piece("black");
  matrix[4][4] = new Piece("white");

  return matrix;
};
