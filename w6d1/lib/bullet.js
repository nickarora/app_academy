(function(){

	var util = new Asteroids.Util();

	var Bullet  = Asteroids.Bullet = function(obj) {
		var COLOR = "green";
    var RADIUS = 4;
    var bulletObj = {
      pos: obj.pos,
      vel: obj.vel,
      radius: RADIUS,
      color: COLOR,
      game: obj.game
    }

    Asteroids.MovingObject.call(this, bulletObj);
	};

	util.inherits(Bullet, Asteroids.MovingObject);

	Bullet.prototype.move = function() {

		if (this.pos[0] > this.game.DIM_X + this.radius || 
				this.pos[0] < 0 - this.radius ||
				this.pos[1] > this.game.DIM_Y + this.radius ||
				this.pos[1] < 0 - this.radius) {
      
      var index = null;

      for(var i = 0; i < this.game.bullets.length; i++) {

        firstX = this.pos[0];
        firstY = this.pos[1];
        secondX = this.game.bullets[i].pos[0];
        secondY = this.game.bullets[i].pos[1];

        if (firstX === secondX && firstY === secondY) {
          index = i;
          break;
        }
      }

      if (index !== null) {
        this.game.bullets.splice(index, 1);
      }

      return;
    }

		this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
	}


})();