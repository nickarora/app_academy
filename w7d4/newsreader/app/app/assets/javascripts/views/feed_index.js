NewsReader.Views.FeedIndex = Backbone.View.extend({
  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, 'sync remove', this.render.bind(this));
    this.subViews = [];
  },

  remove: function(){
    this.subViews.forEach(function(sub){
      sub.remove();
    });

    Backbone.View.prototype.remove.call(this); //super
  },

  render: function () {
    var content = this.template({ feeds: this.collection });
    this.$el.html(content);

    this.collection.each(function(feed){

      var feedView = new NewsReader.Views.FeedIndexItem({ model: feed} );
      this.subViews.push(feedView);

      this.$('ul').append(feedView.render().$el);

    }, this);

    return this;
  }

})
