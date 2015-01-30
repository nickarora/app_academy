NewsReader.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    "" : 'feedsIndex',
    "feeds/:id" : 'feedShow'
  },

  feedsIndex: function(){
    NewsReader.Collections.feeds.fetch();

    var feedIndexView = new NewsReader.Views.FeedIndex({
      collection: NewsReader.Collections.feeds
    });

    this._swapView(feedIndexView);
  },

  feedShow: function(id) {

    var feed = NewsReader.Collections.feeds.getOrFetch(id);

    var feedShowView = new NewsReader.Views.FeedShow({
      model: feed
    });

    this._swapView(feedShowView);
  },

  _swapView: function(newView) {
    if (this._currentView) {
      this._currentView.remove();
    }

    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }

});
