class AdminController < ApplicationController
  before_action :admin_user, only: [:index]

  def index
    @recipes = Recipe.all
    @rType = RecipeType.new
    @rTypes = RecipeType.all
    @ingredients = Ingredient.all
    @iTag = IngredientTag.new
    @iTags = IngredientTag.all
  end

  def admin_user
    unless user_signed_in? and current_user.admin == true
      redirect_to root_url
    end
  end
end
