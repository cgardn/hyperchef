class JoinIngredientsRecipe < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  # All recipe ingredient quantities stores as grams,
  #   this utility converts to whatever measure is needed
  def convert_quantity(target)
  end
    
end
