class Api::V1::Admin::RecipesController < ApplicationController
  include TokenAuthenticatable

  def index
    recipes = {}
    Recipe.all.each do |r|
      recipes[r.id] = r.attributes.except(
        "id", "created_at", "updated_at"
      )
      recipes[r.id]['types'] = r.recipe_types.pluck(:id)
    end

    ingredients = {}
    Ingredient.all.each do |ing|
      ingredients[ing.id] = ing.attributes.except(
        "id", "created_at", "updated_at"
      )
      ingredients[ing.id]['tags'] = ing.ingredient_tags.pluck(:id)
    end

    rTypes = {}
    RecipeType.all.each do |rt|
      rTypes[rt.id] = rt.attributes.slice("name")
    end

    iTags = {}
    IngredientTag.all.each do |it|
      iTags[it.id] = it.attributes.slice("name")
    end

    equip = {}
    Equipment.all.each do |e|
      equip[e.id] = e.attributes.except("id", "created_at", "updated_at")
    end

    render json: {
      recipes: recipes,
      recipe_types: rTypes,
      ingredients: ingredients,
      ingredient_tags: iTags,
      equipment: equip,
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
