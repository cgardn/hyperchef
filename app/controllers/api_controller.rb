class ApiController < ApplicationController

  def all
    #  need some way to pull out the tags on ingredients plus recipe tags and
    #  return them in plain arrays, so the frontend can quickly sort and filter 
    #  without an extra api call
    #  - probably need to change the Recipe model so the tags are denormalized
    #    onto the actual Recipe object, since it only changes on creation+update 
    #    (i.e. when the ingredient list changes, or when the recipe tags are 
    #    edited by an admin)
    
    # current solution below: 
    # on each recipe, does an inner join on each ingredient and the ingredient_tag
    #   table. Can probably do something more advanced like batching all the 
    #   ingredients into a list of unique names, getting all the tags for each 
    #   ingredient, then inserting the tags into the actual recipes
    #   - also likely needs pagination for when we get to large numbers of recipes
    render json: Recipe.all.to_json(
      :methods => :all_tags,
      :only => [:difficulty, :time_score, :ingredient_score, :name, :slug, :saves],
    )
    
  end

  def single
    print params
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
