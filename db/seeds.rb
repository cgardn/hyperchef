# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Creating tags..."
rTypes = RecipeType.create([{name: "salad"},{name: "pastry"},{name: "dinner"},{name: "lunch"},
                            {name: "breakfast"},{name: "quick & easy"},{name: "rice bowls"}])
iTags = IngredientTag.create([{name: "poultry"},{name: "meat"},{name: "red meat"},
                              {name: "vegetable"},{name: "starch"},{name: "root"},
                              {name: "grain"},{name: "leafy greens"},{name: "spice"},
                              {name: "herb"},{name: "liquid"},{name: "fruit"},{name: "citrus"}])
p "done."
puts "Creating ingredients..."

100.times do 
  i = Ingredient.create({name: Faker::Food.unique.ingredient, caloriespergram: rand(100)})
  tags = nil
  while tags == nil || tags.length < 3
    tags = Array.new(rand(3..4)) {rand(1..iTags.length-1)}.uniq!
  end
  tags.length.times do |n|
    i.ingredient_tags << IngredientTag.find(tags[n])
  end
end

puts "done."
puts "Creating Equipment..."
equipment = Equipment.create([{name: "10-inch frying pan"},{name: "4-quart stock pot"},
                              {name: "oven"},{name: "chef's knife"},{name: "paring knife"},
                              {name: "bread knife"},{name: "rice cooker"},
                              {name: "citrus squeezer"},{name: "grater"}])
puts "done, #{equipment.length} pieces created."
puts "Creating Recipes..."
53.times do |n|
  used = []
  r = Recipe.create({name: Faker::Food.unique.dish, origin: Faker::Nation.unique.nationality,
                     author: Faker::Name.name, views: 0, saves: 0})

  i = nil
  while i == nil
    i = Array.new(5) {rand(1..Ingredient.all.length-1)}.uniq!
  end
  e = nil
  while e == nil
    e = Array.new(rand(2..equipment.length)) {rand(1..equipment.length-1)}.uniq!
  end

  puts "ingredients: #{i}"
  puts "equipment: #{e}"

  i.length.times do |n|
    r.ingredients << Ingredient.find(i[n])
    r.set_quantity(Ingredient.find(i[n]).name, rand(1000))
  end
  e.length.times do |n|
    r.equipment << Equipment.find(e[n])
  end

  types = nil
  while types == nil
    types = Array.new(rand(2..rTypes.length)) {rand(1..rTypes.length-1)}.uniq!
  end
  types.length.times do |n|
    r.recipe_types << RecipeType.find(types[n])
  end

  rand(10).times do |n|
    r.actions[n] = {title: Faker::Lorem.sentence(word_count: rand(1..4)),
                    body: Faker::Lorem.paragraph(sentence_count: rand(1..5))}
  end
  r.slug = URI::encode(r.name.gsub(' ','-').downcase)
  r.save
end
