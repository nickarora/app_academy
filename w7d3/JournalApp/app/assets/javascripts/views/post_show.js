JournalApp.Views.PostShow = Backbone.View.extend({

  initialize: function() {
    this.listenTo(this.model, "sync", this.render.bind(this));
    this.open = false;
  },

  template: function() {
    return this.open ? JST["posts/edit"] : JST["posts/show"];
  },

  events: {
    'dblclick .edit': 'beginEditing',
    'blur form': 'endEditing'
  },

  beginEditing: function (event) {
    var $currentTarget = $(event.currentTarget);
    this.open = true;

    if ($currentTarget.hasClass('title')) {
      this.render({ type: 'title' });
    } else {
      this.render({ type: 'body' });
    }
    this.$el.find('input').focus();
    this.$el.find('textarea').focus();
  },

  endEditing: function (event) {
    event.preventDefault();
    this.open = false;

    var postData = $(event.currentTarget).serializeJSON();
    var attr = postData["post"];

    this.model.save( attr, {
      success: (function() {
        Backbone.history.navigate('posts/' + this.model.id, {trigger: true} )
      }).bind(this),

      error: (function(model, errors){
        var content = this.errorTemplate({errors: errors.responseJSON});
        this.$el.prepend(content);
      }).bind(this)
    });
  },

  render: function(options){
    if (!options) {
      options = {type: null};
    }
    var content = this.template()({ post: this.model, type: options.type });
    this.$el.html(content);
    return this;
  }
});
