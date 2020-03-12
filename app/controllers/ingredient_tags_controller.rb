class IngredientTagsController < ApplicationController
  before_action :auth_admin

  def index
    @iTag = IngredientTag.new
    @iTags = IngredientTag.all.order(created_at: :desc)
  end

  def create
    @tag = IngredientTag.new
    @tag.name = tag_params[:tag]
    if @tag.save!
      flash[:info] = "Tag created!"
      redirect_to ingredient_tags_path
    else
      flash[:warning] = "Error saving tag"
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
    redirect_to ingredient_tags_path
  end

  def destroy
    @tag = IngredientTag.find(params[:id])
    @tag.delete
    flash[:warning] = "Tag deleted"
    redirect_to ingredient_tags_path
  end

  private

  def tag_params
    params.require(:ingredient_tag).permit(:tag)
  end

  def auth_admin
    unless user_signed_in? and current_user.admin == true
      redirect_to root_url
    end
  end
end
