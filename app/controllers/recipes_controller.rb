class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @iNames = @recipe.ingredients.map{ |i| i[:name] }
  end

  def update
    @recipe ||= Recipe.find(params[:id]) || Recipe.new

    @recipe.name = recipe_params[:name]
    @recipe.origin = recipe_params[:origin]
    @recipe.author = recipe_params[:author]

    # Setting ingredients list
    puts "cp 1"
    @recipe.ingredients.delete_all
    puts "cp 2"
    
    recipe_params[:ingredients].each do |i|
      puts "cp #{i}"
      unless i[:selected] == "0"
        puts "cp #{i}-bb"
        @recipe.ingredients << Ingredient.find_by(name: i[:selected])
      end
    end

    # Setting action steps hash
    @recipe.actions.clear
    puts recipe_params[:actions]
    p "-"*10
    recipe_params[:actions].each do |a|
      puts a
      p "="*10
      @recipe.actions[a[:order]] = { title: a[:title],
                                          body: a[:body] }
    end
    
    if @recipe.save
      flash[:info] = "Updated recipe!"
      redirect_to '/recipes'
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
    def recipe_params
      params.require(:recipe).permit(:name, :origin, :author,
                                     ingredients: [:selected],
                                     actions: [:title, :order, :body])
    end
  
end
