class ApiController < ApplicationController

  def all
    # current solution: 
    # FilterGraph is a service object in app/services. It builds all the
    #   static recipe data into whatever form is needed, and caches it.
    #   As of 12-3-2020 this app is configured to use the memory store. The
    #   FilterGraph object has one method, graph(), that checks the cache,
    #   rebuilding the data structures if there's a cache miss.
    # Since all the data the user interacts with regarding the actual recipes
    #   is static, we can return 500+ recipes in <100ms straight from cache
    
    render json: FilterGraph.graph()
    
  end

  def get_tags
    # return list of ingredient tags and recipe types for frontend to build
    # filters. This way the frontend doesn't need to hard-code filters, only
    # what is currently in-use from backend gets listed
    rt = RecipeType.all.pluck(:name)
    it = IngredientTag.all.pluck(:name)
    render json: {'Recipe Tags' => rt, 'Ingredient Tags' => it}.to_json
  end

  def single
    if params[:slug]
      recipe = Recipe.find_by(slug: params[:slug])
      render json: recipe.to_json(:include => [:equipment, :ingredients])
    end
  end

  def search
    @results = Recipe.search_names(params[:query])
    render json: @results.to_json(:include => {:ingredients => {:methods => :all_tags }})
  end

  def test
    render json: {msg: "Test"}
  end

end
