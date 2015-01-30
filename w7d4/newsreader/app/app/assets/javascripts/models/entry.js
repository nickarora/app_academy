NewsReader.Models.FeedEntry = Backbone.Model.extend({

  // Is this necessary?
  urlRoot: function(){
    return this.feed.url() + '/entries'
  }

});
