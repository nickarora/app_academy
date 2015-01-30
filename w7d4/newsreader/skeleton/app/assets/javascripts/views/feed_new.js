NewsReader.Views.FeedNew = Backbone.View.extend({
  template: JST['feeds/new'],

  events: {
    "submit form": "submitHandler"
  },

  submitHandler: {
    // not done
  },

  render: function() {
    var content = this.template({ feed: this.model })
    this.$el.html(content);
    return this;
  }
})
