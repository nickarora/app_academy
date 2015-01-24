$.Carousel = function (el) {

  this.$el = $(el);
  this.activeIdx = 0;
  this.$items = this.$el.find('.items')
  this.$items.find(":first-child").addClass('active');
  this.transitioning = false;

  this.bindEvents();
};

$.Carousel.prototype.bindEvents = function () {
  var carousel = this;
  this.$el.on("click", '.slide-left', function(){
    carousel.slide(1);
  });

  this.$el.on("click", '.slide-right', function(){
    carousel.slide(-1);
  });
};

$.Carousel.prototype.unBindEvents = function () {
  this.$el.off("click");
};

$.Carousel.prototype.slide = function (delta) {

  this.unBindEvents();
  var carousel = this;

  var oldPic = this.$items.find(":nth-child(" + (this.activeIdx + 1) + ")");

  this.activeIdx += delta;
  if (this.activeIdx >= 0){
    this.activeIdx = this.activeIdx % (this.$items.find('.item').length);
  }
  else {
    this.activeIdx = this.$items.find('.item').length + delta;
  }

  var curPic = this.$items.find(":nth-child(" + (this.activeIdx + 1) + ")");

  if (delta < 0){
    curPic.addClass('active left');
    setTimeout(function(){
      curPic.removeClass('left');
      oldPic.addClass('right')
    },0);
  } else {

    curPic.addClass('active right');
    setTimeout(function(){
      curPic.removeClass('right');
      oldPic.addClass('left')
    },0);
  }

  curPic.one('transitionend', function(){
    oldPic.removeClass('active');
    oldPic.removeClass('left');
    oldPic.removeClass('right');
    setTimeout(function() {
      carousel.bindEvents();
    }, 50);
  });
}

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
