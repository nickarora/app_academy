

var Board = function(){
  this.grid = initMatrix(8, 8);
};

var Piece = function(color){
  this.color = color;
};

var Game = function(){
  this.board = new Board();
};

///////////////////

Board.prototype.display = function() {
  for (var row = 0; row < this.grid.length; row++) {
    var rowString = row;
    for (var col = 0; col < this.grid[0].length; col++) {
      currentPiece = this.grid[row][col];
      if (!currentPiece) {
        rowString += "_ ";
      } else if (currentPiece.color == "white"){
        rowString += "W ";
      } else {
        rowString += "B ";
      }
    }
    console.log(rowString);
  }
}


Game.prototype.placePiece = function(position, color){
  var x = position[0];
  var y = position[1];
  //dont allow if piece already exists!
  this.board.grid[y][x] = new Piece(color);

  //updateBoard(position);
}

Game.prototype.updateBoard = function(position){
  var DELTAS = [
    [ -1,  0],
    [  1,  0],
    [  0, -1],
    [  0,  1],
    [ -1, -1],
    [ -1,  1],
    [  1, -1],
    [  1,  1]
  ];



  var placedX = position[0];
  var placedY = position[1];
  placedColor = this.getColor(position);

  numFlipped = null;

  for(var i = 0; i < DELTAS.length -1; i++ ){

    vertMove = DELTAS[i][0];
    horiMove = DELTAS[i][1];

    currX = placedX + vertMove;
    currY = placedY + hor;

    while (this.getColor([currX, currY]) != placedColor) {


    }

  }

}

Game.prototype.getColor = function(position){
  var piece = this.board.grid[y][x];
  return piece.color;
}


game = new Game();


// alert(gameBoard.grid.join('\n'))
