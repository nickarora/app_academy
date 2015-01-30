NewsReader.Views.FeedShowItem = Backbone.View.extend({

  template: JST['feeds/feed_show_item'],

  tagName: 'li',

  render: function () {
    var content = this.template({entry: this.model});
    this.$el.html(content);
    return this;
  }
})
