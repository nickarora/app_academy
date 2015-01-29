JournalApp.Views.PostsIndexItems = Backbone.View.extend({
  events: {
    'click .delete': 'deleteHandler'
  },

  template: JST["posts/index_item"],

  tagName: "li",

  deleteHandler: function(event) {
    event.preventDefault();
    this.model.destroy({

      success: (function(){
        Backbone.history.navigate('/posts/home', {trigger: true});
      }).bind(this)
    });

  },

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);

    return this;
  }
});
