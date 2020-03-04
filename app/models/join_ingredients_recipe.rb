class JoinIngredientsRecipe < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  dry_conversions = {
    kilgrams: 0.001,
    pounds: 0.0022,
    ounces: 0.0353}
  
  # Requires density value for non-water, like oil
  wet_conversions = {
    milliliters_water: 1,
    milliliters_oil: 0.916}

  # All recipe ingredient quantities stores as grams,
  #   this utility converts to whatever measure is needed
  def convert_quantity(target)
  end
    
end
