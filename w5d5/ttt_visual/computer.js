function Computer(board) {
  this.mark = "O";
  this.board = board;
};

Computer.prototype.getMove = function(callback){
  var pos = [];
  pos = this.miniMax(this.board, "computer", 0);
  callback(pos);
};

Computer.prototype.miniMax = function(board, player, depth) {
  var that = this;
  var scores = {};
  var bestMove = null;
  var bestScore = null;

  if (board.won()){
    return this.getScore(board);
  }

  board.getAvailableMoves().forEach( function(move){ 
    player == "human" ? board.placeMark(move, 'X') : board.placeMark(move, 'O');
    scores[move] = that.miniMax(board, that.toggle(player), depth + 1) + depth;
    board.deleteMark(move);
  });

  if (player == "computer") {
    var max = this.getMax(scores);
    bestMove = max[0];
    bestScore = max[1];
  } else {
    var min = this.getMin(scores);
    bestMove = min[0];
    bestScore = min[1];
  }

  if (depth == 0) {
    board.winner = null;
    var bestX = parseInt(bestMove.slice(0,1));
    var bestY = parseInt(bestMove.slice(2,3));
    bestMove = [bestX, bestY];
    return bestMove;
  } else {
    return bestScore;
  }
};

Computer.prototype.getMax = function(scores) {

  var highest = null;
  var bestMove = null;
  var keys = Object.keys(scores);
  var vals = [];

  keys.forEach( function(key){
    vals.push(scores[key]);
  });

  highest = Math.max.apply(null, vals);
  highestIdx = vals.indexOf(highest);
  bestMove = keys[highestIdx];

  return [bestMove, highest]
};

Computer.prototype.getMin = function(scores){

  var lowest = null;
  var bestMove = null;
  var keys = Object.keys(scores);
  var vals = [];

  keys.forEach( function(key){
    vals.push(scores[key]);
  });

  lowest = Math.min.apply(null, vals);
  lowestIdx = vals.indexOf(lowest);
  bestMove = keys[lowestIdx];

  return [bestMove, lowest]
}

Computer.prototype.getScore = function(board){
  var winner = board.winner;
  board.winner = null;
  if (winner == "X"){
    return -10;
  } else if (winner == "O") {
    return 10;
  } else {
    return 0;
  }
};

Computer.prototype.toggle = function(p){
  var newPlayer = (p == "computer" ? "human" : "computer");
  return newPlayer;
};


Computer.prototype.getRandomPos = function(){
  var x = this.pickRandom();
  var y = this.pickRandom();

  while ( !this.board.empty([x,y]) ) {
    x = this.pickRandom();
    y = this.pickRandom();
  }

  return [x,y];
};

Computer.prototype.pickRandom = function(){
  return Math.floor(Math.random() * 3);
}
