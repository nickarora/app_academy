Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
  	"submit form": 'savePokemon'
  },

  render: function () {
  	this.$el.html(JST["pokemonForm"]);
  },

  savePokemon: function (event) {
  	event.preventDefault();
  	var pokeAttrs = ($(event.currentTarget).serializeJSON())['pokemon'];
  	
  	var that = this;

  	this.model.save(pokeAttrs, {
  		success: function(){
  			that.collection.add(that.model);
  			Backbone.history.navigate('/pokemon/' + that.model.id, { trigger: true });
  		}
  	});
  }
});
