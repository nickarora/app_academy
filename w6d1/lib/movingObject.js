(function() {

  if (typeof Asteroids === "undefined"){
    window.Asteroids = {};
  }

  var MovingObject = Asteroids.MovingObject = function(obj){
    this.pos = obj.pos;
    this.vel = obj.vel;
    this.radius = obj.radius;
    this.color = obj.color;
    this.game = obj.game;
  }

  MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI,
      false
    );

    ctx.fill();
  }

  MovingObject.prototype.move = function() {

    this.game.wrap(this.pos, this.radius);

    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
  }

  MovingObject.prototype.isCollidedWith = function(otherObject) {
    var dist = Asteroids.Util.prototype.dist(this.pos, otherObject.pos);
    var minimumDist = this.radius + otherObject.radius;
    if (dist < minimumDist) {
      return true;
    } else {
      return false;
    }
  }

})();
