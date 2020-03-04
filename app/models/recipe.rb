class Recipe < ApplicationRecord
  has_many :join_ingredients_recipes
  has_many :ingredients, through: :join_ingredients_recipes

  has_many :join_recipetypes_recipes
  has_many :recipe_types, through: :join_recipetypes_recipes

  has_many :join_equipment_recipes
  has_many :equipment, through: :join_equipment_recipes

  def self.search_names(q)
    unless q.nil?
      where("lower(name) LIKE :query", query: "%#{sanitize_sql_like(q.downcase)}%")
    else
      all
    end
  end

  def all_tags
    rt = recipe_types.pluck(:name)
    it = []
    ingredients.each do |ing|
      it.push(ing.ingredient_tags.pluck(:name))
    end
    rt + it.flatten.uniq
  end

  def set_quantity(ing, amt)
    join_ingredients_recipes.find_by(ingredient_id: Ingredient.find_by(name: ing)).quantity_in_grams = amt
  end

  def ing_quants
    out = {}
    join_ingredients_recipes.each do |i|
      out[Ingredient.find(i.ingredient_id).name] = i.quantity_in_grams
    end
    out
  end

  def join_i(ing)
    join_ingredients_recipes.find_by(ingredient_id: ing.id)
  end


  serialize :actions, Hash
end
