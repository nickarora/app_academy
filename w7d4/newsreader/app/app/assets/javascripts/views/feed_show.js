NewsReader.Views.FeedShow = Backbone.View.extend({

  template: JST['feeds/show'],

  events: {
    "click .refresh": "refreshHandler"
  },

  initialize: function(){
    this.listenTo(this.model, 'sync', this.render.bind(this));
    this.subViews = [];
  },

  remove: function(){
    this.subViews.forEach(function(sub){
      sub.remove();
    });

    Backbone.View.prototype.remove.call(this); //super
  },

  refreshHandler: function() {
    this.model.fetch();
  },

  render: function(){
    var content = this.template({ feed: this.model })
    this.$el.html(content);

    this.model.entries().each(function(entry){

      var entryView = new NewsReader.Views.FeedShowItem({ model: entry });
      this.subViews.push(entryView);

      this.$('ul').append(entryView.render().$el);

    }, this);


    return this;
  }

});
