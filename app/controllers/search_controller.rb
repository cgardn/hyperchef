class SearchController < ApplicationController

  def index
  end

  def query
    @results = Recipe.search_names(params[:query])
    if user_signed_in?
      @favorites = UserProfile.find(current_user.user_profile.id).favorites
    end

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

      filteredResults = []
      @results.each do |r|
        if (r.all_tags & @filter).length == @filter.length
          filteredResults.push(r)
        end
      end

      @results = filteredResults
    end

    @filter.nil? ? @filter = [] : @filter

    # RecipeTypes in use, for filter modal
    @rType_inuse = RecipeType.joins(:recipes).uniq.pluck(:name)
    @checked_filters = @rType_inuse & @filter

    
    @total = Recipe.all.count
    unless @filter.nil?
      @filter = "Filters: " + @filter.join(", ")
    else
      @filter = ""
    end
    
  end

  private
    
    def query_params
      params.require(:query).permit(:query)
    end

end
