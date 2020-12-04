class FilterGraph
  # Creates the graph of all filters and stores it in cache
  # Also retrieves from cache, checking if cached value exists and re-building
  #   if necessary
  # 3 things stored in cache
  #   1. Categorized JSON object of filters
  #      - Hash of array of String filter names, each key named after a filter
  #        category, like "Meals/Meal Types," "Ingredients," "Ingredient
  #        Types," "Dietary restrictions (halal, etc," and os on
  #   2. Batched filter/recipe Hash
  #      - Hash of arrays
  #         - each key is a filter
  #         - each array is a list of all recipe ids that the filter applies
  #           to
  #      -> in the frontend, as filters are checked and unchecked, the various
  #         arrays are grouped and the intersection of all of them is computed
  #         to show the user the matching recipes
  #   3. All the actual recipes in an array, with the data necessary for 
  #      building the Home view recipe components
  #      - this is sent over as an array to save on data, since nested objects
  #        create a lot of extra '{}''s in the stringified JSON object
  # NOTE
  # I am aware this isn't a real graph! this is just the first fastest thing
  #   I came up with since I'm trying to ship instead of spending a week on 
  #   what would likely be a premature optimization

  def self.graph()
    # build filter graph and save in memory store
    #   this MUST be called during server initialization, after that it can
    #   be re-called whenever probably
    # I am aware this can be done with Rails.cache.fetch, but I couldn't 
    #   figure out how quickly enough :embarrassed:
    puts "Retrieving graph"
    if Rails.cache.exist?("all_recipes")
      return Rails.cache.read("all_recipes")
    else
      Rails.cache.write("all_recipes", 

      # build hash of arrays of categorized filters

      # build categorized lists of recipes by filter
      # - get recipe types and all associated recipes
      # - get ingredients and all associated recipes
      # - get ingredient tags and all associated recipes
      # - store in cache as Hash by filter

      # build actual recipes, or at least retrieve them and put in cache
      Recipe.all.to_json(
        :only => [:ingredientTags, :difficulty, :time_score, :ingredient_score, :name, :slug, :saves],
      ))
    end
  end

  def self.get_graph()
    # maybe I can call the graph out of the cache store here? Does that make
    # sense or should I use the cache directly? I should check the cache on
    # each call, just to make sure that it's still around, and rebuild if not
    puts Rails.cache.read("all_filters")
  end
end
