# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Cat.create!(
	name: "Bandit",
	sex: "M",
	birth_date: "2013-10-01",
	color: "orange",
	description: "Will steal your food and your heart"
)

Cat.create!(
	name: "Fluffy",
	sex: "F",
	birth_date: "2012-10-01",
	color: "tabby",
	description: "Sheds more than your mama"
)

Cat.create!(
	name: "Colonel Whiskers",
	sex: "M",
	birth_date: "2014-10-01",
	color: "grey",
	description: "Just don't make him mad and he's great company"
)

Cat.create!(
	name: "Anastasia",
	sex: "F",
	birth_date: "2000-10-01",
	color: "black",
	description: "Warning: only likes foreigners."
)

Cat.create!(
	name: "Princess",
	sex: "F",
	birth_date: "2005-5-01",
	color: "white",
	description: "Doesn't care about you and doesn't hide it."
)