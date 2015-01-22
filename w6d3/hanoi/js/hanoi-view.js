(function(){

  if (typeof Hanoi === "undefined"){
    window.Hanoi = {};
  }

  View = Hanoi.View = function(game, $el){
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.placeDisks();
    this.bindEvents();

  };

  Hanoi.View.prototype.bindEvents = function(){
    var that = this;

    this.$el.on('click', '.tower', function(event){
      that.makeFirstMove($(event.currentTarget));
    });
  };

  Hanoi.View.prototype.makeFirstMove = function($tower){
    var that = this;
    // disable first listener
    this.$el.off("click", "**");

    this.$el.on('click', '.tower', function(event){
      that.makeSecondMove($tower, $(event.currentTarget));
    });
  };

  Hanoi.View.prototype.makeSecondMove = function($tower1, $tower2){

    // disable second listener
    this.$el.off("click", "**");

    var firstTowerNum = $tower1.data('towerNum');
    var secondTowerNum = $tower2.data('towerNum');
    console.log(firstTowerNum, " : ", secondTowerNum);

    if (this.game.move(firstTowerNum, secondTowerNum)){
      this.placeDisks();
    } else {
      alert("Invalid Move");
    }

    if (this.game.isWon()){
      alert("YOU WIN.")
    } else {
      this.bindEvents();
    }
  }

  Hanoi.View.prototype.setupBoard = function(){
    for (var i = 0; i < 3; i++) {
      var $tower = $('<div class="tower">');
      $tower.data('towerNum', i);
      this.$el.append($tower);

      for (var j = 2; j >= 0; j--) {
        var $level = $('<div class="level">');
        $level.addClass('tower-' + i);
        $level.addClass('height-' + j);

        $tower.append($level);
      }
    }
  };

  Hanoi.View.prototype.placeDisks = function(){
    $('.level').empty();
    for(var i = 0; i < 3; i++){
      for(var j = 0; j < 3; j++){
        if( this.game.towers[i][j] ){
          var width = this.game.towers[i][j];
          var $currLevel = $('.tower-' + i + '.height-' + j)
          var $currDisk = $('<div class="disk">');
          $currDisk.addClass("width-" + width);
          $currLevel.append($currDisk);
        }
      }
    }
  }
})();
