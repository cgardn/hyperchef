class Api::V1::Admin::IngredientsController < ApplicationController
  include TokenAuthenticatable
  protect_from_forgery with: :null_session

  def index
    render json: Ingredient.all.pluck(:id, :name)
  end

  def update
    if params[:id]
      ing = Ingredient.find(params[:id])
      ing.name = params[:name]
      ing.caloriespergram = params[:caloriespergram]

      # Remove all tags, re-add the ids that were sent in
      ing.ingredient_tags.delete_all
      params[:tags].each do |it|
        ing.ingredient_tags << IngredientTag.find(it)
      end

      saveResult = ing.save
    end
    FilterGraph.rebuild_filters()
    FilterGraph.rebuild_sorted_recipe_ids()
    render json: ing
  end

  private
  def ing_params
    params.permit(:name,
                  :caloriespergram,
                  iTags: [:selectedIds])
  end


end
