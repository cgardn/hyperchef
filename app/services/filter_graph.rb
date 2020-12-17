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
    if !Rails.cache.exist?("all_recipes")
      Rails.cache.write("all_recipes", build_all_recipes())
    end
    if !Rails.cache.exist?("all_filters")
      Rails.cache.write("all_filters", build_all_filters())
    end
    if !Rails.cache.exist?("sorted_recipe_ids")
      Rails.cache.write("sorted_recipe_ids", build_sorted_recipe_ids())
    end

    return {
      "all_recipes" => Rails.cache.read("all_recipes"),
      "all_filters" => Rails.cache.read("all_filters"),
      "sorted_recipe_ids" => Rails.cache.read("sorted_recipe_ids"),
    }
  end

  class << self

    def build_all_recipes()
      # pluck Recipe fields for building Home view (maybe actually pluck)
      # this should be a Hash keyed by Recipe ID for direct access (ie no 
      #   searching)
      # probably don't need :ingredientTags since build_sorted_recipe_ids?
      puts "Building recipe data for Home view..."
      out = {}
      Recipe.all.each do |r|
        out[r.id] = r.slice(:difficulty, :time_score, :ingredient_score, :name, :slug, :saves)
      end
      return out
    end

    def build_all_filters()
      # build hash of arrays of categorized filters
      # this is for the frontend to build an organized UI of all the different
      #   filter types
      # must ensure only I-Tags that actually have ingredients are included,
      #   and only filters that actually have recipes are included
      puts "Categorizing filters..."
      out = {}
      RecipeType.all.each do |tag|
        if tag.recipes.count < 1
          next
        end
        out[tag.name] = {state: false, type: "recipeType"}
      end
      IngredientTag.all.each do |tag|
        # skip i-tags with no ingredients under them
        if tag.ingredients.count < 1
          next
        end
  
        # for each ingredient in this i-tag category
        #   - skip the ingredient if it's not in any recipes
        #   - add the ingredient filter to the final hash with state and i-tag
        #     as attributes
        #     > frontend will go through and assemble the lists of categories
        #       this allows for direct hash access on this list of ingredients
        #       since those are the things being used, the i-tags are just
        #       for toggling whole groups of ingredients on or off
        tag.ingredients.each do |ing|
          # skip ingredients with no recipes
          if ing.recipes.count < 1
            next
          end

          out[ing.name] = {state: false, itag: tag.name}
        end
      end
      return out
    end

    def build_sorted_recipe_ids()
      # build hash of arrays of recipe ids, keyed by filter
      # each filter is a key, each key has a list of all recipe ids that apply
      #   to that filter
      # frontend performs series of array intersections to produce the
      #   filtered views
      # - get recipe types and all associated recipes
      # - get ingredients and all associated recipes
      # - get ingredient tags and all associated recipes
      # - store in cache as Hash by filter
      puts "Sorting recipe ids by filter..."
      out = {}
      # recipe types
      RecipeType.all.each do |rt|
        out[rt.name] = rt.recipes.pluck(:id)
      end

      # ingredient tags, manual join required
      # this was originally for getting all the ingredient tags on each 
      #   recipe, now its creating a list of recipes for each ingredient tag
      #   so this usage is very inefficient and bad - TODO i'll come back 
      #   later and fix it (12-7-2020)
      puts "Sorting by ingredient tag..."
      Recipe.all.each do |r|
        # this gets all the ingredient tags associated with this recipe
        IngredientTag.joins(ingredients: :recipes).where("recipe_id = ?", r.id).pluck(:name).to_set.each do |tag|
          # for each tag, put r.id (this recipe id) in each tag's list,
          #   creating the array if it doesn't exist
          if out.keys.include?(tag) && out[tag].instance_of?(Array)
            out[tag].push(r.id)
          else
            out[tag] = [r.id]
          end
        end
      end

      # ingredients
      puts "Sorting by ingredient..."
      Ingredient.all.each do |ing|
        out[ing.name] = ing.recipes.pluck(:id)
      end

      # finally, remove duplicate recipe ids
      puts "Removing duplicates..."
      out.keys.each do |tag|
        out[tag] = out[tag].to_set.to_a
      end
      return out

    end

  end
end
