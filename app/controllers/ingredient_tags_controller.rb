class IngredientTagsController < ApplicationController

  def index
    @iTag = IngredientTag.new
    @allTags = IngredientTag.all.order(created_at: :desc)
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
    @allTags = IngredientTag.all.order(created_at: :desc)
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
end
