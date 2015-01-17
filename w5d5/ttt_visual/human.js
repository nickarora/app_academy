
function Human(board) {
  this.board = board;
  this.mark = "X";
}


Human.prototype.getMove = function(callback){
  var that = this;

  var squares = document.getElementsByClassName("square");

  var clickHandler = function(){
    //parse what box was picked
    var x = parseInt(this.id.slice(0,1));
    var y = parseInt(this.id.slice(1,2));
    
    // disable the event listeners
    for(var i=0;i<squares.length;i++){
      squares[i].removeEventListener('click', clickHandler);
    } 

    //handle our input!
    callback([x,y]);
  }

  // set up listener for clicks!
  for(var i=0;i<squares.length;i++){
    squares[i].addEventListener('click', clickHandler);
  } 

};