(function() {
  var Util = Asteroids.Util = function() {};

  Util.prototype.inherits = function(ChildClass, ParentClass) {
    var Surrogate = function() {};
    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
  }

  Util.prototype.randomVec = function(length) {
    var rad = 2 * Math.PI * Math.random(); //degrees bet 0 and 360
    var xVel = Math.floor(Math.sin(rad) * length);
    var yVel = Math.floor(Math.cos(rad) * length);

    return [xVel, yVel];
  }

  Util.prototype.dist = function(pos1, pos2) {
    var a = Math.pow(pos1[0] - pos2[0], 2);
    var b = Math.pow(pos1[1] - pos2[1], 2);
    return Math.sqrt(a + b);
  }

})();
