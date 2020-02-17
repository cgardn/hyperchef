class IngredientTag < ApplicationRecord
  has_many :join_ingredienttags_ingredients
  has_many :ingredients, through: :join_ingredienttags_ingredients
end
