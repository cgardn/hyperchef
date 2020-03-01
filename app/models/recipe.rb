class Recipe < ApplicationRecord
  has_many :join_ingredients_recipes
  has_many :ingredients, through: :join_ingredients_recipes

  has_many :join_recipetypes_recipes
  has_many :recipe_types, through: :join_recipetypes_recipes

  has_many :join_equipment_recipes
  has_many :equipment, through: :join_equipment_recipes

  def self.search_names(q)
    where("lower(name) LIKE :query", query: "%#{sanitize_sql_like(q.downcase)}%")
  end

  def all_tags
    rt = recipe_types.pluck(:name)
    it = []
    ingredients.each do |ing|
      it.push(ing.ingredient_tags.pluck(:name))
    end
    rt + it.flatten.uniq
  end


  serialize :actions, Hash
end
