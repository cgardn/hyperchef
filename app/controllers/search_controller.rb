class SearchController < ApplicationController

  def index
  end

  def browse
    @tags = RecipeType.all.order(name: :desc)
  end

  def browse_query
    @recipes = RecipeType.find_by(name: params[:id]).recipes
  end

  def query
    @q = params[:query]
    @results = Recipe.search_names(params[:query])

    # only filter results by checked boxes if boxes were actually checked
    # - hack to fix top search bar and filter submit button technically
    #   being seperate forms
    
    unless params[:rTypes].to_s + params[:iTags].to_s == ""
      if params[:rTypes].to_s == ""
        @filter = params[:iTags].flatten.reject {
          |n| n[:selected] == "0" }.pluck(:selected)
      elsif params[:iTags].to_s == ""
        @filter = params[:rTypes].flatten.reject {
          |n| n[:selected] == "0" }.pluck(:selected)
      else
        @filter = params[:rTypes].concat(params[:iTags]).flatten.reject {
          |n| n[:selected] == "0" }.pluck(:selected)
      end

      out = []
      @results.each do |r|
        if (r.all_tags & @filter).length == @filter.length
          out.push(r)
        end
      end
      @results = out
    end
    
    @total = Recipe.all.count
    puts @filter
    
  end

  private
    
    def query_params
      params.require(:query).permit(:query)
    end

end
