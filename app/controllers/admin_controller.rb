class AdminController < ApplicationController

  def index
    @recipes = Recipe.all
    @rType = RecipeType.new
    @rTypes = RecipeType.all
    @ingredients = Ingredient.all
    @iTag = IngredientTag.new
    @iTags = IngredientTag.all
  end
end
