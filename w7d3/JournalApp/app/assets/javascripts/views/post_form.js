JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST["posts/post_form"],
  errorTemplate: JST["posts/errors"],

  events: {
    "submit form": "submit"
  },

  initialize: function() {
    this.listenTo(this.model, 'sync', this.render.bind(this));
  },

  submit: function(event){

    console.log("ENTERING SUBMIT FORM");


    event.preventDefault();

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

  render: function(){
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  }
});
