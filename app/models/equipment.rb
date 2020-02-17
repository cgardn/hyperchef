class Equipment < ApplicationRecord
  has_many :join_equipment_recipes
  has_many :recipes, through: :join_equipment_recipes

end
