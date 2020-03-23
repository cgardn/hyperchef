class IngredientsController < ApplicationController
  before_action :lookup_ingredient, except: [:index, :new, :create]

  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
    @tags = @ingredient.all_tags
  end

  def create
    @ingredient = Ingredient.new

    # Setting params manually, since tags are on a join table
    #   and one-step mass-assignment doesn't work
    @ingredient.name = ingredient_params[:name]
    @ingredient.caloriespergram = ingredient_params[:caloriespergram]
    @ingredient.is_liquid = {"0" => false, "1" => true}[ingredient_params[:is_liquid]]

    # Setting tag list
    ingredient_params[:iTags].each do |it|
      unless it[:selected] == "0"
        @ingredient.ingredient_tags << IngredientTag.find_by(name: it[:selected])
      end
    end
    if @ingredient.save!
      redirect_to admin_path
    else
      render :new
    end
  end

  def edit
    @tags = @ingredient.all_tags
  end

  def update
    @ingredient.name = ingredient_params[:name]
    @ingredient.caloriespergram = ingredient_params[:caloriespergram]
    @ingredient.is_liquid = {"0" => false, "1" => true}[ingredient_params[:is_liquid]]

    # Setting tag list
    @ingredient.ingredient_tags.delete_all

    ingredient_params[:iTags].each do |it|
      unless it[:selected] == "0"
        @ingredient.ingredient_tags << IngredientTag.find_by(name: it[:selected])
      end
    end
    
    if @ingredient.save!
      redirect_to admin_path
    else
      render :edit
    end
  end

  def destroy
    @ingredient.delete
    redirect_to admin_path
  end

  private
    def lookup_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    def ingredient_params
      params.require(:ingredient).permit(:name, :caloriespergram, :is_liquid,
                                         iTags: [:selected] )
    end
end
