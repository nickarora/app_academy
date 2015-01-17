//for(var i = 0; i < this.length; i++){}

var printNum = function(n) {
  console.log(n);
}

var timesTwo = function(n) {
  return (n * 2);
}

Array.prototype.myEach = function( func ) {
  for(var i = 0; i < this.length; i++){
    func(this[i]);
  }

  this
};

Array.prototype.myMap = function( func ) {
  var result = [];

  this.myEach( function(el){
    result.push(func(el));
  });

  return result;
};


var sum = function(prior, el){
  return prior + el;
};


Array.prototype.myInject = function(fun) {

  var result = null;

  this.myEach( function(el){
    result = fun(result, el);
  });

  return result;
};
