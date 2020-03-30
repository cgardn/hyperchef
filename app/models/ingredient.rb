class Ingredient < ApplicationRecord
  has_many :join_ingredienttags_ingredients
  has_many :ingredient_tags, through: :join_ingredienttags_ingredients

  has_many :join_ingredients_recipes
  has_many :recipes, through: :join_ingredients_recipes

  serialize :units, Hash

  def all_tags
    tags = []
    ingredient_tags.each do |it|
      tags.push(it[:name])
    end
    tags
  end

  def empty_units
    { 'imperial_show' => [0.0, ""],
      'imperial_list' => [0.0, ""],
      'metric_show' => [0.0, ""],
      'metric_list' => [0.0, ""] }
  end

  def base_unit
    {true => "mL", false => "g"}[is_liquid]
  end

end
