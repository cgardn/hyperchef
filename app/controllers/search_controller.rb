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

=begin
      # Paginating the matching results
      pageSize = 20 # magic for now
      paginatedResults = []
      c = filteredResults.count
      lastPage = c % pageSize)
      numPages = (lastPage == 0 ? (c-lastPage)/pageSize : ((c-lastPage)/pageSize)+1)
      numPages.times do |n|
        paginatedResults.push(filteredResults[0+(pageNum*pageSize)..(pageSize-1)+(pageNum*pageSize))
      end

      @results = paginatedResults
      @numPages = numPages
      @currentPage = 0
=end
      @results = filteredResults
    end
    
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
