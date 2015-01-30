NewsReader.Views.FeedIndexItem = Backbone.View.extend ({
  template: JST['feeds/index_item'],

  events: {
    'click .delete': 'deleteHandler'
  },

  tagName: 'li',

  deleteHandler: function(){
    this.model.destroy();
  },

  render: function () {
    var content = this.template({feed: this.model})
    this.$el.html(content);

    return this;
  }
})
