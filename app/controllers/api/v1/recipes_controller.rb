module Api
  module V1

    class RecipesController < ApplicationController

    # FilterGraph is a service object in app/services. It builds all the
    #   static recipe data into whatever form is needed, and caches it.
    #   As of 12-3-2020 this app is configured to use the memory store. The
    #   FilterGraph object has one method, graph(), that checks the cache,
    #   rebuilding the data structures if there's a cache miss.
    #
    # TODO
    #  - change FilterGraph into more generic caching service that puts
    #      everything into memory right at the start, preferably in separate
    #      objects with individual calls
    #  - shorten field names to reduce overall size
    
      def index
        render json: FilterGraph.graph()
      end
    
      def show
        if params[:slug]
          recipe = Recipe.includes(:equipment, :ingredients).find_by(slug: params[:slug])

          # exclude keys that aren't relevant to user view
          # these attrs also break tests, since time elapses between creating 
          #   the test Recipe and checking the values
          recipe_attrs = recipe.attributes.except(
            "updated_at", "created_at", "ingredientTags", "time_score"
          )
          
          render json: {
            recipe: recipe_attrs,
            ingredients: recipe.ingredients.to_a,
            equipment: recipe.equipment.to_a,
          }
        end
      end
    
    end
  end
end
