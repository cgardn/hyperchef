class JoinIngredienttagsIngredient < ApplicationRecord
  belongs_to :ingredient_tag
  belongs_to :ingredient
end
