// takes an instance of the pokemon model as an argument
Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
	var $li = $('<li/>').text(pokemon.get('name') + ": " + pokemon.get('poke_type'));
	
	$li.addClass('poke-list-item');
	$li.attr('data-id', pokemon.get('id'));

	this.$pokeList.append($li);


};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
	var that = this;

	this.pokes.fetch({
		success: function(){
			that.$pokeList.empty();
			that.pokes.each(function(poke){
				that.addPokemonToList(poke);
			});
		}
	});
};
