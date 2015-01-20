(function() {

  var util = new Asteroids.Util();

  var Asteroid = Asteroids.Asteroid = function(obj) {

    var COLOR = "#E2F0D6"
    var RADIUS = 40;
    var length = Math.floor((Math.random() * 6) + 5);

    var ast = {
      pos: obj.pos,
      vel: util.randomVec(length),
      radius: RADIUS,
      color: COLOR,
      game: obj.game
    }

    Asteroids.MovingObject.call(this, ast);
  };

  util.inherits(Asteroid, Asteroids.MovingObject);

  Asteroid.prototype.collideWith = function(otherObject) {
    if (otherObject instanceof Asteroids.Ship){
      if (!otherObject.invincible){
        this.game.remove(otherObject);
      }
    } else {
      this.game.remove(this);
      this.game.remove(otherObject);
    }
  }


})();
