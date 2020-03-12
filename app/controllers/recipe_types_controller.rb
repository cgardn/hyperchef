class RecipeTypesController < ApplicationController
  before_action :auth_admin

  def index
    @rType = RecipeType.new
    @rTypes = RecipeType.all.order(created_at: :desc)
  end

  def edit
    @rType = RecipeType.find(params[:id])
    @rTypes = RecipeType.all.order(created_at: :desc)
  end

  def update
    @rType = RecipeType.find(params[:id])
    @rType.update_attributes(name: rType_params[:tag])
    redirect_to recipe_types_path
  end

  private
  def rType_params
    params.require(:recipe_type).permit(:tag)
  end

  def auth_admin
    unless user_signed_in? and current_user.admin == true
      redirect_to root_url
    end
  end
end
