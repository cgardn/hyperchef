class Api::V1::Admin::IngredientsController < ApplicationController
  protect_from_forgery with: :null_session

=begin
  def create
  end
  def destroy
  end
=end

  def update
    if params[:id]
      ing = Ingredient.find(params[:id])
      ing = params[:data]
      out = ing.save
    end
    FilterGraph.rebuild_filters()
    render json: ing
  end
  end

end
