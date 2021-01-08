class Api::V1::Admin::RecipesController < ApplicationController
  include TokenAuthenticatable
  protect_from_forgery with: :null_session

  def index
    recipes = Recipe.all.pluck(:id, :name)
    render json: recipes
  end

  def create
    recipe = Recipe.new
    recipe_params.keys.each do |key|
      recipe[key] = recipe_params[key]
    end
    recipe.slug = URI::encode(recipe_params[:name].gsub(' ', '-').downcase)

    # new actions
    recipe.action_array = JSON.parse(action_params[:action_array])
    
    # remove existing types and replace with new ones
    rTypes_params.each do |type|
      recipe.recipe_types << RecipeType.find(type)
    end

    # update ingredients
    ingredient_params.each do |ing|
      recipe.ingredients << Ingredient.find(ing)
    end
    
    # update equipment
    equipment_params.each do |equip|
      recipe.equipment << Equipment.find(equip)
    end

    saveResult = recipe.save
    # rebuild cache with new recipe
    FilterGraph.rebuild_all()
    render json: {}, status: 200
  end

  def show
    if params[:id]
      recipe = Recipe.find(params[:id])
      equipment = recipe.equipment.pluck(:id)
      ingredients = recipe.ingredients.pluck(:id)
      rTypes = recipe.recipe_types.pluck(:id)
      render json: {
        recipe: recipe,
        equipment: equipment,
        ingredients: ingredients,
        rTypes: rTypes
      }
    end
  end

  def update
    if params[:id]
      recipe = Recipe.find(params[:id])
      recipe_params.keys.each do |key|
        recipe[key] = recipe_params[key]
      end
      recipe.slug = URI::encode(recipe_params[:name].gsub(' ', '-').downcase)

      # new actions
      recipe.action_array = JSON.parse(action_params[:action_array])
      
      # remove existing types and replace with new ones
      recipe.recipe_types.delete_all
      rTypes_params.each do |type|
        recipe.recipe_types << RecipeType.find(type)
      end

      # update ingredients
      recipe.ingredients.delete_all
      ingredient_params.each do |ing|
        recipe.ingredients << Ingredient.find(ing)
      end
      
      # update equipment
      recipe.equipment.delete_all
      equipment_params.each do |equip|
        recipe.equipment << Equipment.find(equip)
      end

      saveResult = recipe.save
    end

    # rebuild cache with new recipe
    FilterGraph.rebuild_all()

    render json: recipe
  end

  def destroy
    if params[:id]
      Recipe.find(params[:id]).destroy
      FilterGraph.rebuild_all()
      render json: {}, status: :no_content
    end
  end

  private
    def equipment_params
      params.require(:equipment)
    end

    def ingredient_params
      params.require(:ingredients)
    end

    def rTypes_params
      params.require(:rTypes)
    end

    def action_params
      params.require(:recipe).permit(:action_array)
    end

    def recipe_params
      params.require(:recipe).permit(:name, :author, :origin, 
                                     :prep_time, :cook_time, :difficulty)
    end
end
