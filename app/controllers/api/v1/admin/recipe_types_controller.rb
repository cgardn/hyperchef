class Api::V1::Admin::RecipeTypesController < ApplicationController
  include TokenAuthenticatable
  protect_from_forgery with: :null_session

  def index
    render json: RecipeType.all.pluck(:id, :name)
  end

  def create
    if params[:name]
      rt = RecipeType.new(name: params[:name])
      out = rt.save
    end
    out ? (render json: rt) : (render json: "")
  end

  def update
    if params[:id]
      rType = RecipeType.find(params[:id])
      rType.name = params[:name]
      rType.save
    end
    FilterGraph.rebuild_filters()
    render json: rType 
  end

  def destroy
    if params[:id]
      rType = RecipeType.find(params[:id])
      rType.destroy
    end
  end

  private
  def rType_params 
    params.permit(:id, :name)
  end
end
