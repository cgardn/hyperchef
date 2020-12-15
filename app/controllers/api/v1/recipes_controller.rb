module Api
  module V1

    class RecipesController < ApplicationController

    # FilterGraph is a service object in app/services. It builds all the
    #   static recipe data into whatever form is needed, and caches it.
    #   As of 12-3-2020 this app is configured to use the memory store. The
    #   FilterGraph object has one method, graph(), that checks the cache,
    #   rebuilding the data structures if there's a cache miss.
    # Since all the data the user interacts with regarding the actual recipes
    #   is static, we can return 500+ recipes in <100ms straight from cache
    # TODO change FilterGraph into more generic caching service that puts
    #       everything into memory right at the start, preferably in separate
    #       objects with individual calls
    
      def index
        render json: FilterGraph.graph()
      end
    
      def show
        if params[:slug]
          recipe = Recipe.find_by(slug: params[:slug])
          render json: recipe.to_json(:include => [:equipment, :ingredients])
        end
      end
    
    end
  end
end
