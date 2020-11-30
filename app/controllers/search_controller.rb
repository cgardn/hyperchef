class SearchController < ApplicationController

  def index
  end

  def all_json
    render json: Recipe.all
  end

  def test
    render json: {msg: "Test"}
  end

  def query
    @results = Recipe.search_names(params[:query])

    if user_signed_in?
      @favorites = Recipe.all.eager_load(:user_profiles).where("user_id = ?", current_user.user_profile.id)
    end

    # only filter results by checked boxes if boxes were actually checked
    # - saves some time when nothing is checked
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

      # This still produces one database call per recipe, might be a way to 
      #   do it in a single call
      filteredResults = []
      @results.each do |r|
        if (r.all_tags & @filter).length == @filter.length
          filteredResults.push(r)
        end
      end

      @results = filteredResults
    end

    # Preload all recipes in results here somehow, to avoid N+1 in view
    #  when building cards


    @filter.nil? ? @filter = [] : @filter

    # RecipeTypes in use, for filter modal
    @rType_inuse = RecipeType.joins(:recipes).uniq.pluck(:name)
    @checked_rTypes = @rType_inuse & @filter

    # Ingredient tags in use
    @iTags_inuse = IngredientTag.joins(:ingredients).uniq.pluck(:name)
    @checked_iTags = @iTags_inuse & @filter
    
    # Collecting scores for the recipe cards in one
    #   database call

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
