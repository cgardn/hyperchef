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

  # TODO probably an easier way to do this
  # - also not used for now
  def build_units(i_s, i_su, i_l, i_lu, m_s, m_su, m_l, m_lu)
    { 'imperial_show' => [i_s, i_su],
      'imperial_list' => [i_l, i_lu],
      'metric_show' => [m_s, m_su],
      'metric_list' => [m_l, m_lu] }
  end

  def base_unit
    {true => "mL", false => "g"}[is_liquid]
  end

end
