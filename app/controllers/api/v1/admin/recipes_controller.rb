class Api::V1::Admin::RecipesController < ApplicationController
  include TokenAuthenticatable
  protect_from_forgery with: :null_session

  def index
    recipes = {}
    Recipe.all.each do |r|
      recipes[r.id] = r.attributes.except(
        "created_at", "updated_at", "time_score", "ingredient_score", "ingredientTags"
      )
      # adding recipe types as array of ids, text labels are pulled from
      #   RecipeType object on frontend
      recipes[r.id]['types'] = r.recipe_types.pluck(:id)
    end

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
    if params[:id]
      recipe = Recipe.find(params[:id])
      bulk_params.keys.each do |key|
        recipe[key] = bulk_params[key]
      end
      recipe.slug = URI::encode(bulk_params[:name].gsub(' ', '-').downcase)
      # remove existing actions and replace with new ones
      recipe.actions = {}
      recipe_params[:actions].each_with_index do |action, idx|
        recipe.actions[idx] = [action[:title], action[:body]]
      end

      # remove existing types and replace with new ones
      recipe.recipe_types.delete_all
      recipe_params[:types].each do |type|
        recipe.recipe_types << RecipeType.find(type)
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
    def recipe_params
      params.require(:recipe).permit(types: [],
                                     actions: [:title, :body],
                                     equipment: [],
                                     ingredients: [])
    end
    def bulk_params
      params.require(:recipe).permit(:name, :origin, :author, :prep_time,
                                       :cook_time, :card_image_path,
                                       :difficulty)
    end

end
