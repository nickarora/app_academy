(function(){

  if (typeof window.S === "undefined"){
    window.S = {};
  }


  Snake = S.Snake = function(dir, posArr){

    this.dir = dir;
    this.segments = posArr; // coords
    this.growthCounter = 0;
  }

  Snake.prototype.turn = function(newDir) {
    var legalMoves = {
      'N': ["W", 'E'],
      'S': ["W", 'E'],
      'E': ["N", 'S'],
      'W': ["N", 'S']
    }

    if (legalMoves[this.dir].indexOf(newDir) >= 0){
      this.dir = newDir;
    }
  }

  Snake.prototype.move = function(){
    var delta;
    switch (this.dir) {
      case "N":
        delta = new Coords(-1, 0);
        break;
      case "E":
        delta = new Coords(0, 1);
        break;
      case "S":
        delta = new Coords(1, 0);
        break;
      case "W":
        delta = new Coords(0, -1);
        break;
    }

    var newHead = this.segments[0].plus(delta)
    if (this.growthCounter === 0) {
      this.segments.pop();
    } else {
      this.growthCounter--;
    }

    this.segments.unshift(newHead);
  }

  Coords = S.Coords = function(row, col) {
    this.row = row;
    this.col = col;
  }

  Snake.prototype.isAt = function(otherCoord){

    for( var i = 0; i < this.segments.length; i++){
      if ( this.segments[i].eq(otherCoord)){
        return true;
      }
    }
    return false;
  };

  Snake.prototype.bodyIsAt = function(otherCoord){

    var snakeBody = this.segments.slice(1);

    for( var i = 0; i < snakeBody.length; i++){
      if (snakeBody[i].eq(otherCoord)){
        return true;
      }
    }
    return false;
  };

  Coords.prototype.plus = function(otherCoord){
     var row = this.row + otherCoord.row;
     var col = this.col + otherCoord.col;
     return new Coords(row, col);
  }

  Coords.prototype.eq = function(otherCoord){
    return (this.row == otherCoord.row && this.col == otherCoord.col);
  }

  Board = S.Board = function(width, height) {
    this.grid = [];
    for(var i = 0; i < height; i++) {
      this.grid.push([]);
      for(var j = 0; j < width; j++) {
        this.grid[i].push(null);
      }
    }

    var posArr = [];
    var pos1 = new Coords(Math.floor(height/2), Math.floor(width/2));
    var pos2 = pos1.plus(new Coords(1,0));
    var pos3 = pos2.plus(new Coords(1,0));
    posArr = [pos1, pos2, pos3];

    this.numApples = 0;

    this.snake = new Snake("N", posArr);

    this.growthFactor = 2;
    this.apple = new Apple(this.randomPos(), this.growthFactor);
  };

  Board.prototype.randomPos = function(){
    var row = Math.floor(Math.random() * this.grid.length);
    var col = Math.floor(Math.random() * this.grid[0].length);
    return new Coords(row, col);
  };

  Board.prototype.checkCollisions = function(){
    if (this.snake.isAt(this.apple.pos)){
      this.snake.growthCounter = this.apple.growthFactor;
      this.apple.growthFactor *= 2;
      this.apple.pos = this.randomPos();
      this.numApples += 1;
    }

    // check if self collided
    var head = this.snake.segments[0];
    if (this.snake.bodyIsAt(head)){
      return false;
    }

    // out of bounds?
    if (this.outOfBounds(head)){
      return false;
    }

    return true;
  }

  Board.prototype.outOfBounds = function(pos){
    if (pos.row < 0 ||
        pos.row > this.grid.length - 1 ||
        pos.col < 0 ||
        pos.col > this.grid[0].length - 1 )
        {
          return true;
        }

    return false;
  };

  var Apple = S.Apple = function(pos, growthFactor){
    this.pos = pos;
    this.growthFactor = growthFactor;
  };



})();
