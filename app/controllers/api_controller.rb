class ApiController < ApplicationController

  def all
    #  need some way to pull out the tags on ingredients plus recipe tags and
    #  return them in plain arrays, so the frontend can quickly sort and filter 
    #  without an extra api call
    #  - probably need to change the Recipe model so the tags are denormalized
    #    onto the actual Recipe object, since it only changes on creation+update 
    #    (i.e. when the ingredient list changes, or when the recipe tags are 
    #    edited by an admin)
    
    # current solution: 
    # a rake task (recipe_tags:denormalize) denormalizes all recipe+ingredient
    #   tags onto each recipe model directly. This cuts down the db calls from
    #   ~30ms to ~2ms per row, however now the rake task needs to be run from the
    #   console when new recipes are added or the seed db is recreated. 
    #   Eventually I will add the denormalization to the new Recipe code.
    #
    # this allows us to send all the recipes in one shot to the user, and let the
    #   frontend handle all the heavy lifting of pagination and filtering without
    #   any further hits to the server or db. There (are/will be) options on the
    #   frontend to refresh the recipe list, but as of right now it's <1s for 500
    #   recipes. Not sure how this will scale beyond 500, but also not sure if 
    #   Hyperchef will ever grow beyond (or even up to!) 500 recipes
    render json: Recipe.all.to_json(
      :only => [:ingredientTags, :difficulty, :time_score, :ingredient_score, :name, :slug, :saves],
    )
    
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
