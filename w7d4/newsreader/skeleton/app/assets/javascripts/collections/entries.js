NewsReader.Collections.FeedEntries = Backbone.Collection.extend({

  initialize: function(models, options){ // Why would Ned use (models, options)?
    this.feed = options.feed;
  },

  rootUrl: function(){
    return this.feed.url() + '/entries'
  },

  model: NewsReader.Models.FeedEntry
});
