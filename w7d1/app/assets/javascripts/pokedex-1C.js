Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {

	var that = this;
	var newPokemon = new Pokedex.Models.Pokemon(attrs);

	newPokemon.save(attrs, {
		success: (function(){
			this.pokes.add(newPokemon);
			this.addPokemonToList(newPokemon);
			callback.call(this, newPokemon);
		}).bind(this)
	});

};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
	event.preventDefault();
	var params = $(event.currentTarget).serializeJSON()["pokemon"];
	this.createPokemon(params, this.renderPokemonDetail.bind(this));
};
