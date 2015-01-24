$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data("content-tabs"));
  this.$activeTab = $(this.$contentTabs.find(".active"));
  this.transitioning = false;

  this.$el.on("click", "a", this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function(event){

  event.preventDefault();

  if (this.transitioning) { return; }
  var that = this;


  this.$el.find('a.active').removeClass('active'); // make the link inactive
  var $selectLink = $(event.currentTarget).addClass('active');
  this.$activeTab.removeClass('active').addClass('transitioning');

  this.transitioning = true;

  this.$activeTab.one('transitionend', function(event2){

    console.log("entering transition callback")
    that.$activeTab.removeClass('transitioning');
    that.$activeTab = $($selectLink.attr("href")).addClass('active').addClass('transitioning');

    setTimeout(function(){
      that.$activeTab.removeClass("transitioning");
    }, 0);

    that.transitioning = false;
  });

};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
