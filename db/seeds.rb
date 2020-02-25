# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

IngredientTag.create!(name: "poultry")
IngredientTag.create!(name: "meat")
IngredientTag.create!(name: "red meat")
IngredientTag.create!(name: "vegetable")
IngredientTag.create!(name: "starch")
IngredientTag.create!(name: "root")
IngredientTag.create!(name: "grain")
IngredientTag.create!(name: "leafy greens")
IngredientTag.create!(name: "spice")
IngredientTag.create!(name: "herb")
IngredientTag.create!(name: "liquid")
IngredientTag.create!(name: "fruit")
IngredientTag.create!(name: "citrus")

i = Ingredient.create!(name: "chicken", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "meat")
i.ingredient_tags << IngredientTag.find_by(name: "poultry")
i = Ingredient.create!(name: "ground beef", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "meat")
i.ingredient_tags << IngredientTag.find_by(name: "red meat")
i = Ingredient.create!(name: "iceberg lettuce", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "leafy greens")
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i = Ingredient.create!(name: "romaine lettuce", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "leafy greens")
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i = Ingredient.create!(name: "white rice", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "grain")
i.ingredient_tags << IngredientTag.find_by(name: "starch")
i = Ingredient.create!(name: "brown rice", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "grain")
i.ingredient_tags << IngredientTag.find_by(name: "starch")
i = Ingredient.create!(name: "green zucchini", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i = Ingredient.create!(name: "yellow zucchini", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i = Ingredient.create!(name: "string beans", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i = Ingredient.create!(name: "sweet peas", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i = Ingredient.create!(name: "ginger", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "spice")
i = Ingredient.create!(name: "carrot", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i.ingredient_tags << IngredientTag.find_by(name: "root")
i = Ingredient.create!(name: "broccoli", caloriespergram: 1)
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i = Ingredient.create!(name: "potato", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "root")
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i = Ingredient.create!(name: "spinach", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "vegetable")
i.ingredient_tags << IngredientTag.find_by(name: "leafy greens")
i = Ingredient.create!(name: "soy sauce", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "liquid")
i = Ingredient.create!(name: "sesame oil", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "liquid")
i = Ingredient.create!(name: "olive oil", caloriespergram: 1.65)
i.ingredient_tags << IngredientTag.find_by(name: "liquid")
i = Ingredient.create!(name: "lime", caloriespergram: 1)
i.ingredient_tags << IngredientTag.find_by(name: "fruit")
i.ingredient_tags << IngredientTag.find_by(name: "citrus")


Equipment.create!(name: "10-inch frying pan")
Equipment.create!(name: "4-quart stock pot")
Equipment.create!(name: "oven")
Equipment.create!(name: "chef's knife")
Equipment.create!(name: "paring knife")
Equipment.create!(name: "bread knife")
Equipment.create!(name: "rice cooker")
Equipment.create!(name: "citrus squeezer")
Equipment.create!(name: "grater")

r = Recipe.create!(name: "Ginger-soy ground beef over rice",
                   origin: "Asian-inspired",
                   author: "Cassi Claire",
                   views: 0, saves: 0)
r.ingredients << Ingredient.find_by(name: "ground beef")
r.ingredients << Ingredient.find_by(name: "white rice")
r.ingredients << Ingredient.find_by(name: "green zucchini")
r.ingredients << Ingredient.find_by(name: "soy sauce")
r.ingredients << Ingredient.find_by(name: "ginger")
r.ingredients << Ingredient.find_by(name: "lime")
r.equipment << Equipment.find_by(name: "rice cooker")
r.equipment << Equipment.find_by(name: "chef's knife")
r.equipment << Equipment.find_by(name: "10-inch frying pan")
r.equipment << Equipment.find_by(name: "10-inch frying pan")
r.equipment << Equipment.find_by(name: "citrus squeezer")
r.equipment << Equipment.find_by(name: "grater")

r.actions[1] = {title: "cook rice", body: "Measure however much rice you want into the rice cooker, according to its instructions."}
r.actions[4] = {title: "cook beef", body: "Break up ground beef in pan, and cook on medium-high heat until browned. Try not to stir too much so it'll get nice and crispy."}
r.actions[3] = {title: "cook vegetables", body: "Put the zucchini in one of the pans. Add however much salt and pepper you feel like, and turn on medium heat while you do the next steps."}
r.actions[5] = {title: "season beef", body: "When beef is just about browned, add the soy sauce, sesame oil, and ginger. The soy sauce will sizzle and help crisp the beef. Now's a good time to give the zucchini a stir. If it's getting too brown for your taste, turn the heat down a bit."}
r.actions[2] = {title: "mis en place", body: "Chop zucchini into whatever size you want to eat. Peel ginger root. Get out the soy sauce and some salt and pepper and put it nearby where you're going to cook."}
r.actions[6] = {title: "plate it!", body: "The rice should be done by now. If it isn't, just cover the meat+veg and turn off the heat while you wait. When the rice is done, scoop it onto the plate and squeeze half a lime over each person's portion. Portion beef and zucchini onto each plate. Enjoy!"}
r.save

t = Recipe.create!(name: "Chicken and broccoli with mashed potatoes",
                   origin: "American",
                   author: "me",
                   views: 0, saves: 0)
t.ingredients << Ingredient.find_by(name: "chicken")
t.ingredients << Ingredient.find_by(name: "broccoli")
t.ingredients << Ingredient.find_by(name: "potato")
t.actions[1] = {title: "cook chicken", body: "Put the chicken in a pan with a little oil and cook it until it's not raw anymore."}
t.actions[2] = {title: "cook broccoli", body: "At the same time, put the broccoli in a pan with a little oil, salt, and pepper, and cook on medium heat, covered."}
t.actions[3] = {title: "cook potatoes", body: "Poke both potatoes a bunch of times with a sharp knife, making sure the knife goes all the way through. Put them on a plate and microwave for 6-8 minutes, depending on how big they are. The smaller the potato, the more likely the part touching the plate turns into a dry crunchy potato-chip sort of texture (though you may like that.)"}
t.save
