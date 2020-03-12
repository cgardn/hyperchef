class Ingredient < ApplicationRecord
  has_many :join_ingredienttags_ingredients
  has_many :ingredient_tags, through: :join_ingredienttags_ingredients

  has_many :join_ingredients_recipes
  has_many :recipes, through: :join_ingredients_recipes

  def all_tags
    tags = []
    ingredient_tags.each do |it|
      tags.push(it[:name])
    end
    tags
  end

  def asdf
  end

end
