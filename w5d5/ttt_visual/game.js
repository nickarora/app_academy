var Game = function(board, computer, human){
  this.board = board;
  this.computer = computer;
  this.human = human;
  this.turn = human;
};

Game.prototype.run = function(completionCallback) {
  var that = this;

  var handleInput = function(pos) {
    var success = that.board.placeMark(pos, that.turn.mark);
    if (!success) {
      document.getElementById("output").innerHTML="Invalid Choice!";
      that.run(completionCallback);
    } else {
      if ( that.board.won() ) {
        completionCallback();
      } else {
        that.turn = (that.turn === that.human ? that.computer : that.human);
        that.run(completionCallback);
      }
    }
  }

  this.board.display();

  if (this.turn === this.human) {
    this.human.getMove(function(pos){
      handleInput(pos)
    });
  } else{
    setTimeout(function(){ //artificial delay to simulate a human thinking!
      that.computer.getMove(function(pos){
        handleInput(pos)
      });
    }, 250);
  }

};
