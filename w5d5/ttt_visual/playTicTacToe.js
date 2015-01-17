var board = new Board();
var computer = new Computer(board);
var human = new Human(board);
var game = new Game(board, computer, human);

game.run(function(){
  
  board.display();

  if (board.winner == null){
  	document.getElementById("output").innerHTML="Draw!";	
  } else {
  	document.getElementById("output").innerHTML=board.winner + " Wins!";	
  }
});
