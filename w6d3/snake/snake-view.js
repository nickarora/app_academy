(function(){

  var View = S.View = function(width, height, $el){

    this.width = width;
    this.height = height;

    this.$el = $el;
    this.board = new S.Board(width, height);
    this.snake = this.board.snake;
    this.apple = this.board.apple;
    this.turnFlag = false;

    this.initBoard();

    this.bindListeners();
    var that = this;
    this.gameLoop = setInterval(function(){
      that.step();
    }, 50);
  };

  View.prototype.initBoard = function(){

    for(var row = 0; row < this.height; row++) {
      for(var col = 0; col < this.width; col++) {
        var $cell = $('<div class="cell" >');
        $cell.addClass('row-' + row);
        $cell.addClass('col-' + col);
        this.$el.append($cell);
      }
    }
  };

  View.prototype.drawBoard = function(){

    $('.cell').css('background-color', '#eee');

    this.snake.segments.forEach(function(pos){
      $('.row-' + pos.row + '.col-' + pos.col).css('background-color', 'green');
    });

    var aPos = this.apple.pos;
    $('.row-' + aPos.row + '.col-' + aPos.col).css('background-color', 'red');
  };

  // main game loop
  View.prototype.step = function(){
    this.resetTurnFlag();
    this.drawBoard();
    this.drawScore();
    this.snake.move();
    if (!this.board.checkCollisions()) {
      this.gameOver();
    }
  };

  View.prototype.drawScore = function(){
    $('.score').text("Score: " + this.board.numApples * 10);
  }
  View.prototype.resetTurnFlag = function(){
    this.turnFlag = false;
  }

  View.prototype.gameOver = function() {
    clearInterval(this.gameLoop);
    $('.gameover').css('display', 'block');
  };


  View.prototype.bindListeners = function(){
    var that = this;
    $(window).keydown(function(event){
      that.handleKeyEvent(event.keyCode);
    });
  };


  // bind to listener
  View.prototype.handleKeyEvent = function(key) {
    if (!this.turnFlag) {
      this.turnFlag = true;
      switch (key) {
        case 38:
          this.snake.turn('N');
          break;
        case 39:
          this.snake.turn('E');
          break;
        case 40:
          this.snake.turn('S');
          break;
        case 37:
          this.snake.turn('W');
          break;
        }
    }
  };

})();
