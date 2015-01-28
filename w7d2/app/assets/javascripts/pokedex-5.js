Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li': 'selectPokemonFromList' 
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var liContent = JST["pokemonListItem"]({ pokemon: pokemon });
    this.$el.append(liContent);
  },

  refreshPokemon: function (options) {
    var that = this;

    this.collection.fetch({
      success: function(){
        that.render();
        if (!(typeof options === "undefined")){
          options.success(); //what is this?
        }
      }

    });
  },

  render: function () {
    var that = this;
    this.$el.empty();
    this.collection.forEach(function(pokemon) {
      that.addPokemonToList(pokemon);
    });
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.currentTarget);
    var pokeId = $target.data('id');
    Backbone.history.navigate('/pokemon/' + pokeId,
                              {trigger: true});

    // var pokemon = this.collection.get(pokeId);
    // var pokemonDetail = new Pokedex.Views.PokemonDetail({
    //   model: pokemon
    // });
    // $("#pokedex .pokemon-detail").html(pokemonDetail.$el);
    // pokemonDetail.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    'click .toys li': 'selectToyFromList'
  },

  refreshPokemon: function (options) {
    var that = this;
    this.model.fetch({
      success: function(){
        that.render();
        if (!(typeof options === "undefined")){
          options.success();
        }
      }
    });
  },

  render: function () {
    var content = JST['pokemonDetail']({pokemon: this.model});
    this.$el.html(content);

    this.$el.find(".toys").empty();
    this.model.toys().each((function(toy) {
      content = JST['toyListItem']({toy: toy});
      this.$el.find(".toys").append(content);
    }).bind(this));
  },

  selectToyFromList: function (event) {

    var $target = $(event.currentTarget);
    var toyId = $target.data('id');
    var pokeId = $target.data('pokemon-id');
    Backbone.history.navigate('/pokemon/' + pokeId + '/toys/' + toyId,
                              {trigger: true});


    // var $target = $(event.currentTarget);
    // var toyId = $target.data('id');
    // var toy = this.model.toys().get(toyId);
    // var toyDetail = new Pokedex.Views.ToyDetail({
    //   model: toy
    // });
    // $("#pokedex .toy-detail").html(toyDetail.$el);
    // toyDetail.render();
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.empty();
    var content = JST['toyDetail']({toy: this.model, pokes: []});
    this.$el.html(content);
  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });

