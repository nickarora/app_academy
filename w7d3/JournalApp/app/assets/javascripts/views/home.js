JournalApp.Views.Home = Backbone.View.extend({
  template: JST["posts/home"],

  render: function(){
    var content = this.template();
    this.$el.html(content);

    return this;
  }
});
