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
    render json: {
      recipes: recipes,
      recipe_types: RecipeType.all,
      ingredients: Ingredient.all,
      ingredient_tags: IngredientTag.all,
      equipment: Equipment.all,
    }
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    if params[:id]
      recipe = Recipe.find(params[:id])
      render json: recipe.to_json(:include => [:equipment, :ingredients])
    end
  end

  def update
  end

  def destroy
  end
end
