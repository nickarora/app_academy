(function() {

  var KEYUP = '38';
  var KEYDOWN = '40';
  var KEYRIGHT = '39';
  var KEYLEFT = '37';

  var GameView = Asteroids.GameView = function(canvasEl) {
    this.ctx = canvasEl.getContext("2d");
    this.game = new Asteroids.Game();
    this.keyPresses = {
      KEYUP: false,
      KEYDOWN: false,
      KEYLEFT: false,
      KEYRIGHT: false
    };
  }

  GameView.prototype.bindKeyHandlers = function() {
    window.addEventListener("keydown", this.keyboardDown.bind(this), false);
    window.addEventListener("keyup", this.keyboardUp.bind(this), false);
  }

  GameView.prototype.keyboardDown = function(e) {
    if (e.keyCode == KEYUP ||
        e.keyCode == KEYDOWN ||
        e.keyCode == KEYLEFT ||
        e.keyCode == KEYRIGHT) {
      this.keyPresses[e.keyCode] = true;
    }
  }


  GameView.prototype.keyboardUp = function(e) {
    if (e.keyCode == KEYUP ||
        e.keyCode == KEYDOWN ||
        e.keyCode == KEYLEFT ||
        e.keyCode == KEYRIGHT) {
      this.keyPresses[e.keyCode] = false;
    }
  }

  GameView.prototype.updateImpulse = function() {

    if (this.keyPresses[KEYUP] == true) { //up
      this.game.ship.power([0,-2]);
    }
    if (this.keyPresses[KEYDOWN] == true) { //down
      this.game.ship.power([0,2]);
    }
    if (this.keyPresses[KEYRIGHT] == true) { //right
      this.game.ship.power([2,0]);
    }
    if (this.keyPresses[KEYLEFT] == true) { //left
      this.game.ship.power([-2,0]);
    }

  };


  GameView.prototype.start = function() {

    var self = this;

    console.log(this.keyPresses);

    this.bindKeyHandlers();

    window.setInterval((function () {
      self.game.step();
      self.updateImpulse();
      self.game.draw(this.ctx);
    }).bind(self), 1000 / 20);
  }

})();
