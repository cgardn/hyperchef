class Api::V1::Admin::RecipeTypesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: RecipeType.all.pluck(:id, :name)
  end
end
