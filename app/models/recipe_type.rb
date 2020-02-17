class RecipeType < ApplicationRecord
  has_many :join_recipetypes_recipes
  has_many :recipes, through: :join_recipetypes_recipes
end
