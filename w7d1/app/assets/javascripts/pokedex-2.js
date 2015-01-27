Pokedex.RootView.prototype.addToyToList = function (toy) {

	var $li = $('<li />');

	innerHTML = '';

	innerHTML += '<i>Toy</i><br>'

	keys = ['name', 'happiness', 'price'];
	keys.forEach(function(key){
  	innerHTML += '<strong>' + key + '</strong>' + ": " 
  							+ toy.get(key) + '<br>'; 
  });

  $li.html(innerHTML);
  $li.addClass('poke-list-item');
  $li.attr('data-toy-id', toy.get('id'));

  this.$pokeDetail.find('.toys').append($li);

};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {

	var $div = $('<div />').addClass('detail');
	$div.prepend('<img style="float:none" src="' + toy.get('image_url') + '" />')
	this.$toyDetail.append($div);

};

Pokedex.RootView.prototype.selectToyFromList = function (event) {

	event.preventDefault();	
	
	var that = this;
	var pokemonId = $(event.delegateTarget).data('pokemon-id');
	var toyId = $(event.currentTarget).data('toy-id');
	var pokemon = new Pokedex.Models.Pokemon({ id: pokemonId });

	pokemon.fetch({
  	success: function () {
    	pokemon.toys().forEach(function(toy) {
    		if (toy.get('id') === toyId){
    			that.renderToyDetail(toy);
    		}
    	});
  	}
	});

};
