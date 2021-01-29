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

    # new action_array
    recipe.action_array = JSON.parse(action_params[:action_array])
    
    # remove existing types and replace with new ones
    rTypes_params.each do |type|
      recipe.recipe_types << RecipeType.find(type)
    end

    # update ingredients
    ingredient_params.each do |ing|
      recipe.ingredients << Ingredient.find(ing[0])
      jir = JoinIngredientsRecipe.new({
        recipe_id: recipe.id,
        ingredient_id: ing[0],
        show_quantity: ing[2],
        show_unit: ing[3],
        list_quantity: ing[4],
        list_unit: ing[5],
      })
      jir.save
      recipe.join_ingredients_recipes << jir
    end

    # ingredient count normalized to 100 for index view
    r.ingredient_score = r.normalize(r.ingredients.count, 1,15,10,100).to_i
    
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
      # get ingredient ids, names, and show/list quants/units
      ingredients = []
      recipe.join_ingredients_recipes.each do |ir|
        # [id, name, sQ, sU, lQ, lU]
        ingredients.push([
          ir.ingredient_id,
          Ingredient.find(ir.ingredient_id).name,
          ir.show_quantity,
          ir.show_unit,
          ir.list_quantity,
          ir.list_unit,
        ])
      end
      rTypes = recipe.recipe_types.pluck(:id)
      # nest recipe data under 'recipe', add ingredients, equipment, rTypes
      #   as their own attributes at the same level, and then you can get rid
      #   of the other api calls in the frontend admin recipe show view for
      #   the info needed to list all the checkboxes at the bottom. Instead
      #   everything will be packed into here - since we're doing so much
      #   work to collect the join table quantites etc, we might as well just
      #   grab everything here and save on some api calls
      # TODO convert Ingredient model to an ActiveModel or ActiveHash, if 
      #      quantities are on the join table then Ingredient is just static
      #      data
      allIngredients = Ingredient.all.pluck(:id, :name)
      allIngredients.map! do |ing|
        match = ingredients.find { |obj| obj[0] == ing[0]}
        if match
          match
        else
          [ing[0], ing[1], 0, 'g', 0, 'g']
        end
      end
      # now get all the rTypes
      allRTypes = RecipeType.all.pluck(:id, :name)

      # compose giant object for frontend
      render json: {
        recipe: {
          recipe: recipe,
          equipment: equipment,
          ingredients: ingredients,
          rTypes: rTypes
        },
        ingredients: allIngredients,
        rTypes: allRTypes,
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

      # new action_array
      recipe.action_array = JSON.parse(action_params[:action_array])
      
      # remove existing types and replace with new ones
      recipe.recipe_types.delete_all
      rTypes_params.each do |type|
        recipe.recipe_types << RecipeType.find(type)
      end

      # update ingredients
      # remove old ingredient associations
      recipe.join_ingredients_recipes.each do |ir|
        ir.delete
      end

      # add new ingredient associations
      ingredient_params.each do |ing|
        JoinIngredientsRecipe.new({
          recipe_id: recipe.id,
          ingredient_id: ing[0],
          show_quantity: ing[2],
          show_unit: ing[3],
          list_quantity: ing[4],
          list_unit: ing[5],
        }).save
      end
      
      # update ingredient score
      r.ingredient_score = r.normalize(r.ingredients.count, 1,15,10,100).to_i

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
      render json: {}, status: :ok
      FilterGraph.rebuild_all()
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
