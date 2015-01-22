(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }


  var View = TTT.View = function (game, $el) {
    this.$el = $el;
    this.game = game;
    this.setupBoard();
    this.bindEvents();

  };


  View.prototype.bindEvents = function () {
    var that = this;
    this.$el.on('click', '.square', function(event){
      that.makeMove($(event.currentTarget));
    });
  };


  View.prototype.makeMove = function ($square) {
    var row = $square.data('row');
    var col = $square.data('col')
    var currentMark = this.game.currentPlayer;
    try {
      this.game.playMove([col, row]);
    }
    catch(err){
      alert("Invalid move");
      return;
    }

    $square.css('background-color', 'white');
    $square.text(currentMark);
    if (this.game.winner()) {
      $('#msg').text("The winner is: " + this.game.winner());
    }

  };


  View.prototype.setupBoard = function () {
    for (var i = 0; i < 3; i++) {
      var $newRow = $('<div class="row">');
      this.$el.append($newRow);
      for (var j = 0; j < 3; j++) {
        var $curSquare = $('<div class="square">');
        $curSquare.data('row', i);
        $curSquare.data('col', j);
        $newRow.append($curSquare);
      }
    }
  };


})();
