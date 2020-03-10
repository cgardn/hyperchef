class RecipesController < ApplicationController
  before_action :clean_params_ingredients, only: [:update, :create]
  before_action :set_recipe, only: [:new, :show, :edit, :update]

  def set_recipe
    if params[:name]
      @recipe = Recipe.find_by(name: params[:name])
    else
      @recipe = Recipe.new
    end
  end

  def index
    @recipes = Recipe.all
  end
  
  def new
    #@recipe = Recipe.new
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
  end

  def edit
    @tags = @recipe.all_tags
    @iNames = @recipe.ingredients.map{ |i| i[:name] }
    @iQuants = @recipe.ing_quants
    @eNames = @recipe.equipment.map{ |e| e[:name] }
  end

  def update

    @recipe.name = recipe_params[:name]
    @recipe.origin = recipe_params[:origin]
    @recipe.author = recipe_params[:author]

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
    @recipe.actions.clear
    recipe_params[:actions].each do |a|
      # skip blank steps - form has 20 empty slots, workaround until
      #   proper UI for recipe creation
      if a[:body] == ""
        next
      end
      # Handling multiple steps with the same order number
      if @recipe.actions.keys.include?(a[:order])
        @recipe.actions[(a[:order].to_i+1).to_s] = { title: a[:title],
                                          body: a[:body] }
      else
        @recipe.actions[a[:order]] = { title: a[:title],
                                          body: a[:body] }
      end
    end
    
    if @recipe.save
      flash[:info] = "Updated recipe!"
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect_to recipes_path
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
                                     rTypes: [:selected],
                                     equipment: [:selected],
                                     :ingredients => {},
                                     actions: [:title, :order, :body])
    end
  
end
