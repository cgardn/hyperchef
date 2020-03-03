class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to ingredients_path
    else
      render :new
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
    @tags = @ingredient.all_tags
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.name = ingredient_params[:name]
    @ingredient.caloriespergram = ingredient_params[:caloriespergram]

    # Setting tag list
    @ingredient.ingredient_tags.delete_all

    ingredient_params[:iTags].each do |it|
      unless it[:selected] == "0"
        @ingredient.ingredient_tags << IngredientTag.find_by(name: it[:selected])
      end
    end
    
    if @ingredient.save!
      redirect_to ingredients_path 
    else
      render :edit
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.delete
    flash[:warning] = "Ingredient deleted"
    redirect_to ingredients_path
  end

  private
    def ingredient_params
      params.require(:ingredient).permit(:name, :caloriespergram,
                                         iTags: [:selected] )
    end
end
