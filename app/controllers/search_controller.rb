class SearchController < ApplicationController

  def index
  end

  def browse
    @tags = RecipeType.all.order(name: :desc)
  end

  def browse_query
  end

  def query
    @q = params[:query]
    @results = Recipe.search_names(params[:query])
  end

  private
    
    def query_params
      params.require(:query).permit(:query)
    end

end
