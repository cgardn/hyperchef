class Api::V1::Admin::RecipesController < ApplicationController
  include TokenAuthenticatable

  def index
    recipes = {}
    Recipe.all.each do |r|
      recipes[r.id] = [
        r.name,
        r.ingredients.count,
        r.equipment.count
      ]
    end
    render json: recipes
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients.sort_by{ |obj| obj.name }
    render json: {
      recipe: @recipe,
      ingredients: @ingredients
    }
  end

  def update
  end

  def destroy
  end
end
