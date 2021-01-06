class Api::V1::Admin::IngredientTagsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: IngredientTag.all.pluck(:id, :name)
  end

  def create
    if params[:name]
      it = IngredientTag.new(name: params[:name])
      out = it.save
    end
    out ? (render json: it) : (render json: "")
  end

  def update
    if params[:id]
      iTag = IngredientTag.find(params[:id])
      iTag.name = params[:name]
      iTag.save
    end
    FilterGraph.rebuild_filters()
    render json: iTag
  end

  def destroy
    if params[:id]
      iTag = IngredientTag.find(params[:id])
      iTag.destroy
    end
  end
end
