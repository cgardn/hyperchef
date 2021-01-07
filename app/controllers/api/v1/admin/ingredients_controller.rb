class Api::V1::Admin::IngredientsController < ApplicationController
  include TokenAuthenticatable
  protect_from_forgery with: :null_session

  def index
    render json: Ingredient.all.pluck(:id, :name)
  end

  def show
    if params[:id]
      ing = Ingredient.find(params[:id])
      iTags = ing.ingredient_tags.pluck(:id)
    end
    render json: {
      ing: ing,
      iTags: iTags,
    }
  end

  def create
    ing = Ingredient.new
    ing.name = ing_params[:name]
    ing.caloriespergram = ing_params[:caloriespergram]
    ing.units = JSON.parse(ing_params[:units])
    tag_params.each do |it|
      ing.ingredient_tags << IngredientTag.find(it)
    end
    ing.save
    FilterGraph.rebuild_all()
  end

  def update
    if params[:id]
      ing = Ingredient.find(params[:id])
      ing.name = ing_params[:name]
      ing.caloriespergram = ing_params[:caloriespergram]

      # parse and update units
      ing.units = JSON.parse(ing_params[:units])

      # Remove all tags, re-add the ids that were sent in
      ing.ingredient_tags.delete_all
      tag_params.each do |it|
        ing.ingredient_tags << IngredientTag.find(it)
      end

      saveResult = ing.save
    end
    FilterGraph.rebuild_recipes()
    FilterGraph.rebuild_filters()
    FilterGraph.rebuild_sorted_recipe_ids()
    render json: ing
  end

  private
  def ing_params
    params.require(:ing).permit(:name,
                                :caloriespergram,
                                :units)
  end
  def tag_params
    params.require(:iTags)
  end


end
