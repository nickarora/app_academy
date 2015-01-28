Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": 'pokemonIndex',
    "pokemon/:id": 'pokemonDetail',
    "pokemon/:pokemonId/toys/:toyId": 'toyDetail'
  },

  pokemonDetail: function (id, callback) {

    var that = this;

    if (!this._pokemonIndex){
      this.pokemonIndex(function(){
        that.pokemonDetail(id, callback);
      });
      return;
    }

    var pokemon = this._pokemonIndex.collection.get(id);
    this._pokemonDetail = new Pokedex.Views.PokemonDetail({
      model: pokemon
    });

    $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
    this._pokemonDetail.refreshPokemon({
      success: callback
    });
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this._pokemonIndex.refreshPokemon({
      success: callback
    });

    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {

    var that = this;

    if (!this._pokemonDetail){
      this.pokemonDetail(pokemonId, function(){
        that.toyDetail(pokemonId, toyId);
      });
      return;
    }

    var toy = this._pokemonDetail.model.toys().get(toyId);
    var toyDetail = new Pokedex.Views.ToyDetail({
      model: toy
    });

    $("#pokedex .toy-detail").html(toyDetail.$el);
    toyDetail.render();
  },

  pokemonForm: function () {
    var pokemon = new Pokedex.Models.Pokemon();

    this._form = new Pokedex.Views.PokemonForm({
      model: pokemon,// automatically bound as iVars in the view
      collection: this._pokemonIndex.collection
    });

    $('#pokedex .pokemon-form').html(this._form.$el);
    this._form.render();
  }

});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});

