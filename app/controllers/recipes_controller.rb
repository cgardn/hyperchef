class RecipesController < ApplicationController

  before_action :clean_params_ingredients, only: [:update, :create]
  before_action :set_recipe, only: [:new, :show, :edit, :update]
  before_action :set_user_profile, only: [:show]

  def set_recipe
    if params[:slug]
      @recipe = Recipe.find_by(slug: params[:slug])
    else
      @recipe = Recipe.new
    end
  end

  def index
    @recipes = Recipe.all
  end
  
  def new
    20.times do |n|
      @recipe.actions[(n+1).to_s] = {title: "", body: ""}
    end
    @iNames = @recipe.ingredients.map{ |i| i[:name] }
    @eNames = @recipe.equipment.map{ |e| e[:name] }
    @tags = []
    render :edit
  end

  def show
    @tags = @recipe.all_tags
    @ingredients = @recipe.ingredients
    @quants = @recipe.ing_quants(params[:convert], 1)
  end

  def edit
    @tags = @recipe.all_tags
    @iNames = @recipe.ingredients.map{ |i| i[:name] }
    @iQuants = @recipe.ing_quants
    @eNames = @recipe.equipment.map{ |e| e[:name] }

    # if less than 20 steps, add blank steps until 20
    aCount = @recipe.actions.keys.count
    if aCount == 0
      20.times do |n|
        @recipe.actions[(n).to_s] = {title: "", body: ""}
      end
    elsif aCount < 20
      (20 - aCount).times do |n|
        @recipe.actions[(n+aCount).to_s] = {title: "", body: ""}
      end
    end

  end

  def update

    # encoding name for storage
    @recipe.name = recipe_params[:name]
    @recipe.slug = URI::encode(recipe_params[:name].gsub(' ','-').downcase)

    @recipe.origin = recipe_params[:origin]
    @recipe.author = recipe_params[:author]

    @recipe.cook_time = recipe_params[:cook_time]
    @recipe.prep_time = recipe_params[:prep_time]
    @recipe.card_image_path = recipe_params[:card_image_path]

    # Setting Recipe Type tag list
    @recipe.recipe_types.delete_all

    recipe_params[:rTypes].each do |rt|
      unless rt[:selected] == "0"
        @recipe.recipe_types << RecipeType.find_by(name: rt[:selected])
      end
    end

    # Setting equipment list
    @recipe.equipment.delete_all

    recipe_params[:equipment].each do |e|
      unless e[:selected] == "0"
        @recipe.equipment << Equipment.find_by(name: e[:selected])
      end
    end

    # Setting ingredients list
    @recipe.ingredients.delete_all
    
    @fresh_ing.keys.each do |key|

      # Need to create a Join_Ingredients_Recipes directly here
      #   since the join model has an extra attribute (quantity)
      jir = JoinIngredientsRecipe.new
      jir.recipe = @recipe
      jir.ingredient = Ingredient.find_by(name: key)
      jir.quantity_in_grams = @fresh_ing[key]
      jir.save

    end

    # Setting action steps hash
    # - putting all new steps in fresh Hash, preserves existing steps if
    #   there's any errors with parsing the params
    newActionHash = {}
    recipe_params[:actions].each_with_index do |a, n|
      # skip blank steps - form has 20 empty slots, workaround until
      #   proper UI for recipe creation
      if a[:body] == ""
        next
      end
=begin
      newActionHash[a[:order]] = { title: a[:title],
                                          body: a[:body] }
=end
      newActionHash[n] = [ a[:title], a[:body] ]
    end
    @recipe.actions = newActionHash
    if @recipe.save
      redirect_to admin_path
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find_by(name: params[:name])
    @recipe.delete
    redirect_to admin_path
  end

  private

    def clean_params_ingredients
      @fresh_ing = {}
      recipe_params[:ingredients].keys.each do |key|
        unless recipe_params[:ingredients][key] == ""
          @fresh_ing[key] = recipe_params[:ingredients][key]
        end
      end
      @fresh_ing
    end

    def recipe_params
      params.require(:recipe).permit(:name, :origin, :author,
                                     :prep_time, :cook_time,
                                     :card_image_path,
                                     rTypes: [:selected],
                                     equipment: [:selected],
                                     :ingredients => {},
                                     actions: [:title, :order, :body])
    end

    def set_user_profile
      if user_signed_in?
        @favorites = UserProfile.find(current_user.user_profile.id).favorites
      end
    end
  
end
