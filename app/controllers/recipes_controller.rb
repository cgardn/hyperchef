class RecipesController < ApplicationController

  before_action :admin_user, except: [:show]
  before_action :set_recipe, only: [:new, :show, :edit, :update]
  before_action :set_user_profile, only: [:show]


  def new
    20.times do |n|
      @recipe.actions[(n+1).to_s] = {title: "", body: ""}
    end
    @iNames = @recipe.ingredients.map{ |i| i[:name] }
    @eNames = @recipe.equipment.map{ |e| e[:name] }
    @rTypes = @recipe.recipe_types.all
    @tags = []
    @allIngredients = Ingredient.all.sort_by{ |ing| ing.name }
    render :edit
  end

  def show
    @ingredients = @recipe.ingredients

    # picking :selected for unit select tag
    unless params[:convert].nil?
      if params[:convert] == "false"
        @unit_selector = "imperial_show"
        @chosen = params[:convert]
      elsif params[:convert] == "true"
        @unit_selector = "metric_show"
        @chosen = params[:convert]
      end
    else
      @unit_selector = "imperial_show"
      @chosen = "false"
    end

    params[:servings].nil? ? @servings = 1 : @servings = params[:servings].to_i
  end

  def edit
    @rTypes = @recipe.recipe_types.pluck(:name)
    @iNames = @recipe.ingredients.map{ |i| i[:name] }
    @allIngredients = Ingredient.all.sort_by{ |ing| ing.name }
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

    # most meals between 5 and 75 minutes
    # 5 for salads
    # 75 for 1-hour bake + 15-min prep
    # normalize on 10-100 for progress bars
    @recipe.time_score = @recipe.normalize(
      @recipe.cook_time + @recipe.prep_time,
      5.0, 75.0, 10.0, 100.0).to_i

    # ingredients max around 15-20, so 
    # normalize on 10-100 for progress bars
    @recipe.ingredient_score = @recipe.normalize(
      recipe_params[:ingredients].count,
      1.0, 15.0, 10.0, 100.0).to_i

    # difficulty recorded from 1-10,
    # multiplied by 10 for bar width
    @recipe.difficulty = recipe_params[:difficulty]

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
    
    recipe_params[:ingredients].each do |i|
      @recipe.ingredients << Ingredient.find_by(name: i[:selected])
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

      newActionHash[n] = [ a[:title], a[:body] ]
    end
    @recipe.actions = newActionHash
    if @recipe.save
      redirect_to root_url
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

    def admin_user
      unless user_signed_in? && current_user.admin?
        redirect_to root_url
      end
    end

    def recipe_params
      params.require(:recipe).permit(:name, :origin, :author,
                                     :prep_time, :cook_time, :difficulty,
                                     :card_image_path,
                                     rTypes: [:selected],
                                     equipment: [:selected],
                                     ingredients: [:selected],
                                     actions: [:title, :order, :body])
    end

    def set_user_profile
      if user_signed_in?
        @favorites = UserProfile.find(current_user.user_profile.id).favorites
      end
    end

    def set_recipe
      if params[:slug]
        @recipe = Recipe.find_by(slug: params[:slug])
      else
        @recipe = Recipe.new
      end
    end
  
end
