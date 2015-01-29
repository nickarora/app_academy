JournalApp.Routers.JournalRouter = Backbone.Router.extend({
  routes: {
    "": 'postsIndex',
    "posts/new": 'postNew',
    "posts/home": 'postsHome',
    "posts/:id": 'postShow',
    "posts/:id/edit" : 'postEdit'
  },

  initialize: function(options){
    this.$sidebar = options.domSidebar;
    this.$el = options.domEl;
  },

  postsIndex: function(){
    JournalApp.Collections.posts.fetch();
    var indexView = new JournalApp.Views.PostsIndex({
      collection: JournalApp.Collections.posts
    });

    this.$sidebar.html(indexView.render().$el);
    this.postsHome();
  },

  postsHome: function() {
    var homeView = new JournalApp.Views.Home();
    this._swapView(homeView);
  },

  postNew: function(){
    var post = new JournalApp.Models.Post();

    var postNewForm = new JournalApp.Views.PostForm({
      model: post
    });

    this._swapView(postNewForm)
  },

  postShow: function(id){
    var post = JournalApp.Collections.posts.getOrFetch(id);

    var postView = new JournalApp.Views.PostShow({
      model: post
    });

    this._swapView(postView);
  },

  postEdit: function(id){
    var post = JournalApp.Collections.posts.getOrFetch(id);

    var postEditForm = new JournalApp.Views.PostForm({
      model: post
    });

    this._swapView(postEditForm);
  },

  _swapView: function(newView){
    if (this.currentView){
      this.currentView.remove();
    }

    this.$el.html(newView.render().$el);

    this.currentView = newView;
  }

});
