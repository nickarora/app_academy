JournalApp.Views.PostsIndex = Backbone.View.extend({
  template: JST["posts/index"],

  initialize: function () {
    this.listenTo(this.collection, 'sync add change:title reset remove', this.render.bind(this));
  },

  render: function(){
    var content = this.template();
    this.$el.html(content);
    var that = this;

    this.collection.each(function(post){
      var postView = new JournalApp.Views.PostsIndexItems({
        model: post
      });

      var renderedPost = postView.render();
      that.$el.find('.post-list').append(renderedPost.$el);
    });


    return this;
  }
});
