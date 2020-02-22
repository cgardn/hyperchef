class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @steps = @recipe.actions.order(order: :asc)
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @steps = @recipe.actions.order(order: :asc)
  end

  def update
  end

  private
    def recipe_params
      params.require(recipe).permit
  
end
