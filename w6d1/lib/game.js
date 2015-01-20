(function(){

  var DIM_X = 640;
  var DIM_Y = 480;
  var NUM_ASTEROIDS = 10;


  var Game = Asteroids.Game = function(){
    // create asteroids
    this.allAsteroids = [];
    this.addAsteroids = function(){
      for(var i = 0; i < NUM_ASTEROIDS; i++){
        randX = Math.floor((Math.random() * DIM_X))
        randY = Math.floor((Math.random() * DIM_Y))
        var newAsteroid = {
          pos: [randX, randY],
          game: this
        }
        this.allAsteroids.push(new Asteroids.Asteroid(newAsteroid));
      }
    };
    this.addAsteroids();

    // create ship
    var newShip = { pos: [DIM_X / 2, DIM_Y / 2], game: this };
    this.ship = new Asteroids.Ship(newShip);
    this.ship.makeVulnerable();

    // prepare for bullets
    this.bullets = [];
  };

  Game.prototype.allObjects = function() {
    return this.allAsteroids.concat([this.ship]).concat(this.bullets);
  };

  Game.prototype.draw = function(ctx){
    this.clearScreen(ctx);

    this.allObjects().forEach(function(obj){
      obj.draw(ctx);
    });

  }

  Game.prototype.won = function(ctx){
    this.clearScreen(ctx);
    ctx.fillStyle = "white";
    ctx.font = "bold 60px Arial";
    ctx.fillText("GREAT JOB!", 130, 260);
  };

  Game.prototype.clearScreen = function(ctx) {
    ctx.fillStyle="#10222B";
    ctx.fillRect(0, 0, DIM_X, DIM_Y);
  }

  Game.prototype.moveObjects = function() {
    this.allObjects().forEach(function(obj){
      obj.move();
    });
  }

  Game.prototype.wrap = function(pos, radius) {
    if (pos[0] > DIM_X + radius ) {
      pos[0] = 0 - radius;
    }

    if (pos[0] < 0 - radius) {
      pos[0] = DIM_X + radius;
    }

    if (pos[1] > DIM_Y + radius) {
      pos[1] = 0 - radius;
    }

    if (pos[1] < 0 - radius) {
      pos[1] = DIM_Y + radius;
    }
  };

  Game.prototype.checkCollisions = function() {
    var curNumObjects = this.allObjects().length;

    for(var i = 0; i < curNumObjects; i++) {
      for(var j = 0; j < curNumObjects; j++){
        if (i != j) {
          obj1 = this.allObjects()[i];
          obj2 = this.allObjects()[j];
          if (obj1 instanceof Asteroids.Asteroid &&
              (obj2 instanceof Asteroids.Ship || obj2 instanceof Asteroids.Bullet)) {
              if (obj1.isCollidedWith(obj2)){
                obj1.collideWith(obj2);
                return;
              }
          }
        }
      }
    }
  }

  Game.prototype.respawnShip = function() {
    this.ship.pos = [DIM_X / 2, DIM_Y / 2];
    this.ship.vel = [0,0];
    this.ship.makeVulnerable();
  }

  Game.prototype.remove = function(obj) {

    if (obj instanceof Asteroids.Asteroid) {

      var index = null;

      for(var i = 0; i < this.allAsteroids.length; i++) {

        firstX = obj.pos[0];
        firstY = obj.pos[1];
        secondX = this.allAsteroids[i].pos[0];
        secondY = this.allAsteroids[i].pos[1];

        if (firstX === secondX && firstY === secondY) {
          index = i;
          break;
        }
      }

      if (index !== null) {
        this.allAsteroids.splice(index, 1);
      }
    } else if (obj instanceof Asteroids.Bullet) {

      var index = null;

      for(var i = 0; i < this.bullets.length; i++) {

        firstX = obj.pos[0];
        firstY = obj.pos[1];
        secondX = this.bullets[i].pos[0];
        secondY = this.bullets[i].pos[1];

        if (firstX === secondX && firstY === secondY) {
          index = i;
          break;
        }
      }

      if (index !== null) {
        this.bullets.splice(index, 1);
      }

    } else if (obj instanceof Asteroids.Ship) {

      this.respawnShip(); /* CALL RESPAWN INSTEAD*/

    }
  }

  Game.prototype.step = function() {
    this.moveObjects();
    this.ship.manageSpeed();
    this.checkCollisions();
  }

})();
