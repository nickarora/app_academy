Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {

	var that = this;
	var div = $('<div/>').addClass('detail');
	
	div.prepend('<img style="float:none" src="' + pokemon.get('image_url') + '" />')
	for(key in pokemon.attributes) {
	  if (key != 'image_url' && key != 'id') {
	     var p = $('<p />');
	     p.html('<strong>' + key + '</strong>' + ": " + pokemon.get(key))
	     div.append(p);
	  }
  }

  var toyList = $('<ul />').addClass('toys');
  
  div.append(toyList);
	this.$pokeDetail.append(div);
	this.$pokeDetail.attr('data-pokemon-id', pokemon.get('id'));

	pokemon.fetch({
		success: function(){
			var toys = pokemon.toys();
			toys.forEach(function(toy){
				that.addToyToList(toy);
			});
		}
	});

};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {

	event.preventDefault();

	var id = $(event.currentTarget).data('id');

	var pokemon = new Pokedex.Models.Pokemon({ id: id });
	pokemon.fetch({
  	success: function () {
    	Pokedex.rootView.renderPokemonDetail(pokemon);
  	}
	});
};
