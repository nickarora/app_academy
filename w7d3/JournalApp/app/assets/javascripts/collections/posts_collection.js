JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: '/posts',
  model: JournalApp.Models.Post,

  getOrFetch: function (id) {
    var that = this;

    var post = this.get(id);

    if (post) {
      post.fetch();
    } else {
      post = new JournalApp.Models.Post({id: id});
      post.fetch({
        success: function() {
          that.add(post);
        }
      })
    }

    return post;
  }
});


JournalApp.Collections.posts = new JournalApp.Collections.Posts();
