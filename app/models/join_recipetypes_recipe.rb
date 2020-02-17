class JoinRecipetypesRecipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :recipe
end
