class IngredientTagsController < ApplicationController
  before_action :admin_user

  def index
    @iTag = IngredientTag.new
    @iTags = IngredientTag.all.order(created_at: :desc)
  end

  def create
    @tag = IngredientTag.new
    @tag.name = tag_params[:tag]
    if @tag.save!
      redirect_to admin_path
    else
      render :new
    end
  end

  def edit
    @iTag = IngredientTag.find(params[:id])
    @iTags = IngredientTag.all.order(created_at: :desc)
  end

  def update
    @tag = IngredientTag.find(params[:id])
    @tag.update_attributes(name: tag_params[:tag])
    redirect_to admin_path
  end

  def destroy
    @tag = IngredientTag.find(params[:id])
    @tag.delete
    redirect_to admin_path
  end

  private

  def tag_params
    params.require(:ingredient_tag).permit(:tag)
  end

  def admin_user
    unless user_signed_in? and current_user.admin == true
      redirect_to root_url
    end
  end
end
