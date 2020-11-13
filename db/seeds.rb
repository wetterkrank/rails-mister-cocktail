require 'json'
require 'open-uri'
require 'csv'

# Additional bulk import from CSV
puts "Adding some stuff into DB..."

my_ingredients = []
CSV.foreach('db/seeds/ingredients.csv') { |row| my_ingredients << row[0].strip }
my_ingredients.each { |ing| Ingredient.create(name: ing) }

puts "Done."
exit

# This is the initial seeding
puts "Cleaning database now..."
Cocktail.destroy_all
Ingredient.destroy_all
puts "Database clean ✅"

# Get some ingredients to work with
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
list_serialized = open(url).read
ingredients = JSON.parse(list_serialized)
ingredients["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end

# Make one cocktail as well
ice = Ingredient.create(name: 'Ice')
vodka = Ingredient.create(name: 'Vodka')
ice_vodka = Cocktail.create(name: 'Ice Vodka')

dose = Dose.new(description: "50ml")
dose.ingredient = vodka
dose.cocktail = ice_vodka
dose.save

dose = Dose.new(description: "2 cubes")
dose.ingredient = ice
dose.cocktail = ice_vodka
dose.save

puts "Done! Created #{Ingredient.count} ingredients and #{Cocktail.count} cocktails."