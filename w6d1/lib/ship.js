(function() {

  var util = new Asteroids.Util();

  var Ship  = Asteroids.Ship = function(obj) {

    var COLOR = "red";
    var RADIUS = 20;

    this.invincible = true;
    this.flash = 0;

    var shipObj = {
      pos: obj.pos,
      vel: [0, 0],
      radius: RADIUS,
      color: COLOR,
      game: obj.game
    }

    Asteroids.MovingObject.call(this, shipObj);
  };

  util.inherits(Ship, Asteroids.MovingObject);

  Ship.prototype.makeVulnerable = function() {
    var ship = this;
    this.invincible = true;
    this.color = "red";
    this.flash = 0;
    setTimeout(function() {
      ship.color = "green";
      ship.invincible = false;
    }, 2000);
  }

  Ship.prototype.draw = function(ctx) {
    if (this.invincible) {
      this.flash += 1;
      if (this.flash > 3){
        this.color = (this.color == "red" ? "black" : "red");
        this.flash = 0;
      }
    }


    Asteroids.MovingObject.prototype.draw.call(this, ctx)
  }

  Ship.prototype.power = function(impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  }

  Ship.prototype.manageSpeed = function() {
    if(this.vel[1] < 0) {
      this.vel[1] += 0.5;
    }
    if(this.vel[1] > 0) {
      this.vel[1] -= 0.5;
    }
    if(this.vel[0] < 0) {
      this.vel[0] += 0.5;
    }
    if(this.vel[0] > 0) {
      this.vel[0] -= 0.5;
    }
  }

  Ship.prototype.fireBullet = function(){
    
    bulletPos = this.pos.slice();
    bulletVel = this.vel.slice();

    var bulletObj = {
      pos: bulletPos,
      vel: bulletVel,
      game: this.game
    };

    newBullet = new Asteroids.Bullet(bulletObj);
    this.game.bullets.push(newBullet);
  }

})();
