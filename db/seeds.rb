# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Creating recipe and ingredient tags - must be done first to assign to actual ingredients/recipes
puts "Creating tags..."
rTypes = RecipeType.create([{name: "unused tester"}, {name: "salad"},
                            {name: "pastry"},{name: "dinner"},{name: "lunch"},
                            {name: "breakfast"},{name: "quick & easy"},
                            {name: "rice bowls"}])

iTags = IngredientTag.create([{name: "unused ingredient tag"},
                              {name: "poultry"},{name: "meat"},
                              {name: "red meat"},{name: "vegetable"},
                              {name: "starch"},{name: "root"},{name: "grain"},
                              {name: "leafy greens"},{name: "spice"},
                              {name: "herb"},{name: "liquid"},{name: "fruit"},
                              {name: "citrus"}])
puts "done."

# Creating ingredients
puts "Creating ingredients..."

imperial_units = ['oz', 'tsp']
metric_units = ['g', 'mL']

50.times do 
  b_liquid = false
  if rand(2) == 1
    b_liquid = true
  end

  i = Ingredient.new({name: Faker::Food.unique.ingredient, caloriespergram: rand(100), is_liquid: b_liquid})

  u = {}
  u['imperial_show'] = [rand(1..10), imperial_units[rand(imperial_units.length)]]
  u['imperial_list'] = [rand(1..10), imperial_units[rand(imperial_units.length)]]
  u['metric_show'] = [rand(1..10), metric_units[rand(metric_units.length)]]
  u['metric_list'] = [rand(1..10), metric_units[rand(metric_units.length)]]
  i.units = u
  i.save
  
  tags = nil
  while tags == nil || tags.length < 3
    tags = Array.new(rand(3..4)) {rand(2..iTags.length-1)}.uniq!
  end

  tags.length.times do |n|
    i.ingredient_tags << IngredientTag.find(tags[n])
  end
end


puts "done."

# Creating Equipment
puts "Creating Equipment..."
equipment = Equipment.create([{name: "10-inch frying pan"},{name: "4-quart stock pot"},
                              {name: "oven"},{name: "chef's knife"},{name: "paring knife"},
                              {name: "bread knife"},{name: "rice cooker"},
                              {name: "citrus squeezer"},{name: "grater"}])
puts "done, #{equipment.length} pieces created."

# Creating recipes
puts "Creating Recipes..."
53.times do |n|
  used = []
  r = Recipe.create({name: Faker::Food.unique.dish, origin: Faker::Nation.unique.nationality,
                     author: Faker::Name.name, views: 0, saves: 0})

  i = nil
  while i == nil
    i = Array.new(rand(1..15)) {rand(1..Ingredient.all.length-1)}.uniq!
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
    types = Array.new(rand(2..rTypes.length)) {rand(2..rTypes.length-1)}.uniq!
  end
  types.length.times do |n|
    r.recipe_types << RecipeType.find(types[n])
  end

  rand(2..15).times do |n|
    r.actions[n] = [Faker::Lorem.sentence(word_count: rand(1..4)),
                    Faker::Lorem.paragraph(sentence_count: rand(1..5))]
  end

  r.prep_time = rand(5..30)
  r.cook_time = rand(0..45)
  r.difficulty = rand(1..10)

  r.slug = URI::encode(r.name.gsub(' ','-').downcase)
  r.save!
end

# Creating users
puts "Creating admin"
u = User.new(email: "admin@test.gov", password: "passwordasdf", password_confirmation: "passwordasdf", admin: true)
profile = UserProfile.new
profile.user = u
rand(1..10).times do |n|
  profile.favorites << Recipe.find(rand(1..53))
end
profile.save
u.save!
puts "done."

puts "Creating 20 users"
20.times do |n|
  puts "#{n}..."
  u = User.new(email: Faker::Internet.email, password: "passwordasdf", password_confirmation: "passwordasdf")
  profile = UserProfile.new
  profile.user = u
  rand(1..10).times do |n|
    profile.favorites << Recipe.find(rand(1..53))
  end
  profile.save
  u.save
end
puts "done."
