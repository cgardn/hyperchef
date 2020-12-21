class Api::V1::Admin::IngredientTagsController < ApplicationController
  protect_from_forgery with: :null_session

  def update
    if params[:id]
      iTag = IngredientTag.find(params[:id])
      iTag.name = params[:name]
      iTag.save
    end
    render json: iTag
  end
end
