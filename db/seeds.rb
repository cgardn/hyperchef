# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

startTime = Time.now
checkpoint = startTime

# Creating recipe and ingredient tags - must be done first to assign to actual ingredients/recipes
puts "Creating tags..."
rTypes = RecipeType.create([{name: "salad"},
                            {name: "pastry"},{name: "dinner"},{name: "lunch"},
                            {name: "breakfast"},{name: "quick & easy"},
                            {name: "rice bowls"}])

iTags = IngredientTag.create([{name: "poultry"},{name: "meat"},
                              {name: "red meat"},{name: "vegetable"},
                              {name: "starch"},{name: "root"},{name: "grain"},
                              {name: "leafy greens"},{name: "spice"},
                              {name: "herb"},{name: "liquid"},{name: "fruit"},
                              {name: "citrus"}])
puts "Tag creation finished in %0.2f seconds" % [Time.now - startTime]
checkpoint = Time.now

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
  while tags == nil || tags.length < 2
    tags = Array.new(rand(3..4)) {rand(2..iTags.length-1)}.uniq!
  end

  tags.length.times do |n|
    i.ingredient_tags << IngredientTag.find(tags[n])
  end
end

puts "Ingredients done in %0.2f seconds" % [Time.now - checkpoint]
checkpoint = Time.now

# Creating Equipment
puts "Creating Equipment..."
equipment = Equipment.create([{name: "10-inch frying pan"},{name: "4-quart stock pot"},
                              {name: "oven"},{name: "chef's knife"},{name: "paring knife"},
                              {name: "bread knife"},{name: "rice cooker"},
                              {name: "citrus squeezer"},{name: "grater"}])
puts "Equipment done in %0.2fs" % [Time.now - checkpoint]
checkpoint = Time.now
puts "#{equipment.length} pieces created."

# Creating recipes
puts "Creating Recipes..."
500.times do |n|
  rTime = Time.now
  rTimeCheck = rTime
  used = []
  r = Recipe.create({name: Faker::Number.unique.number(digits: 3), origin: Faker::Nation.nationality,
                     author: Faker::Name.name, views: 0, saves: 0})

  i = Array.new(rand(2..8)) {rand(1..Ingredient.all.length-1)}.to_set.to_a
  e = Array.new(rand(2..equipment.length)) {rand(1..equipment.length-1)}.to_set.to_a

  puts "ingredients: #{i}"
  puts "equipment: #{e}"
  puts "Created in %0.2f seconds" % [Time.now - rTimeCheck]
  rTimeCheck = Time.now

  i.each do |ing|
    r.ingredients << Ingredient.find(ing)
  end
  e.each do |eq|
    r.equipment << Equipment.find(eq)
  end

  puts "Relations added in %0.2f seconds" % [Time.now - rTimeCheck]
  rTimeCheck = Time.now

  types = Array.new(rand(2..rTypes.length)) {rand(2..rTypes.length-1)}.to_set.to_a
  types.each do |t|
    r.recipe_types << RecipeType.find(t)
  end

  puts "Meal Types added in %0.2f seconds" % [Time.now - rTimeCheck]
  rTimeCheck = Time.now

  rand(2..15).times do |n|
    r.actions[n] = [Faker::Lorem.sentence(word_count: rand(1..4)),
                    Faker::Lorem.paragraph(sentence_count: rand(1..5))]
  end

  puts "Actions added in %0.2f seconds" % [Time.now - rTimeCheck]
  rTimeCheck = Time.now

  r.prep_time = rand(5..30)
  r.cook_time = rand(0..45)
  r.difficulty = rand(1..10)

  r.ingredient_score = r.normalize(
    r.ingredients.count,
    1.0, 15.0, 10.0, 100.0).to_i

  r.slug = URI::encode(r.name.gsub(' ','-').downcase)
  r.save!
  puts "Scores and slug added in %0.2f seconds" % [Time.now - rTimeCheck]
  puts "Recipe finished in %0.2f seconds" % [Time.now - rTime]
end

puts "All Recipes finished in %0.2fs" % [Time.now - checkpoint]

# Creating users
puts "Creating admin"
u = ApiUser.new(email: "admin@test.gov", password: "passwordasdf")
u.save!
puts "Everything done in %0.2fs total" % [Time.now - startTime]
=begin old admin user creation
u = User.new(email: "admin@test.gov", password: "passwordasdf", password_confirmation: "passwordasdf", admin: true)
profile = UserProfile.new
profile.user = u
rand(1..10).times do |n|
  profile.favorites << Recipe.find(rand(1..53))
end
profile.save
u.save!
puts "done."
=end
