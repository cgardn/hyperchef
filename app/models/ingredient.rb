class Ingredient < ApplicationRecord
  has_many :join_ingredienttags_ingredients
  has_many :ingredient_tags, through: :join_ingredienttags_ingredients

  has_many :join_ingredients_recipes
  has_many :recipes, through: :join_ingredients_recipes
end
