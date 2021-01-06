class Api::V1::Admin::RecipesController < ApplicationController
  include TokenAuthenticatable
  protect_from_forgery with: :null_session

  def index
    recipes = Recipe.all.pluck(:id, :name)
    render json: recipes
  end

=begin
    recipes = {}
    Recipe.all.each do |r|
      # excluding actions because it has been replaced by action_array
      recipes[r.id] = r.attributes.except(
        "actions", "created_at", "updated_at", "time_score", "ingredient_score", "ingredientTags"
      )
      # adding recipe types as array of ids, text labels are pulled from
      #   RecipeType object on frontend
      recipes[r.id]['types'] = r.recipe_types.pluck(:id)
    end
=end

=begin misguided attempt - what was I thinking here?
    ingredients = {}
    Ingredient.all.each do |ing|
      ingredients[ing.id] = ing.attributes.except(
        "id", "created_at", "updated_at"
      )
      # same as recipetypes above
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
=end

    #render json: {recipeList: recipes}
=begin
    render json: {
      recipes: recipes,
      recipe_types: rTypes,
      ingredients: ingredients,
      ingredient_tags: iTags,
      equipment: equip,
    }
=end

  def create
  end

  def new
  end

  def edit
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
      #render json: recipe.to_json(:include => [:equipment, :ingredients])
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
    FilterGraph.rebuild_filters()
    FilterGraph.rebuild_sorted_recipe_ids()

    render json: recipe
  end

  def destroy
    if params[:id]
      Recipe.find(params[:id]).destroy
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
