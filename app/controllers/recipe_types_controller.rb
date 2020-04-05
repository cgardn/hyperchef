class RecipeTypesController < ApplicationController
  before_action :admin_user

  def index
    @rType = RecipeType.new
    @rTypes = RecipeType.all.order(created_at: :desc)
  end

  def edit
    @rType = RecipeType.find(params[:id])
    @rTypes = RecipeType.all.order(created_at: :desc)
  end

  def create
    @rType = RecipeType.new
    @rType.name = rType_params[:tag]
    if @rType.save!
      redirect_to admin_path
    else
      render :new
    end
  end

  def update
    @rType = RecipeType.find(params[:id])
    @rType.update_attributes(name: rType_params[:tag])
    redirect_to admin_path
  end

  def destroy
    @rType = RecipeType.find(params[:id])
    @rType.delete
    redirect_to admin_path
  end

  private
  def rType_params
    params.require(:recipe_type).permit(:tag)
  end

  def admin_user
    unless user_signed_in? and current_user.admin == true
      redirect_to root_url
    end
  end
end
