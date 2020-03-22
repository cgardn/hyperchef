class Recipe < ApplicationRecord
  has_many :join_ingredients_recipes
  has_many :ingredients, through: :join_ingredients_recipes

  has_many :join_recipetypes_recipes
  has_many :recipe_types, through: :join_recipetypes_recipes

  has_many :join_equipment_recipes
  has_many :equipment, through: :join_equipment_recipes

  has_many :join_userprofiles_recipes
  has_many :user_profiles, through: :join_userprofiles_recipes

  accepts_nested_attributes_for :ingredients

  def self.search_names(q)
    unless q.nil?
      where("lower(name) LIKE :query", query: "%#{sanitize_sql_like(q.downcase)}%")
    else
      all
    end
  end

  def to_param
    slug
  end

  def all_tags
    rt = recipe_types.pluck(:name)
    it = []
    ingredients.each do |ing|
      it.push(ing.ingredient_tags.pluck(:name))
    end
    rt + it.flatten.uniq
  end

  def set_quantity(ing, amt)
    ingquant = join_ingredients_recipes.find_by(ingredient_id: Ingredient.find_by(name: ing))
    ingquant.quantity_in_grams = amt
    ingquant.save
  end

  def ing_quants(convert = false, multiplier = 1)
    if convert.nil?
      convert = false
    elsif convert = "true"
      convert = true
    end
    out = {}

    join_ingredients_recipes.each do |i|
      ingredient = Ingredient.find(i.ingredient_id)
      out[ingredient.name] = build_text_units(i.quantity_in_grams,
                                              ingredient.is_liquid,
                                              multiplier,
                                              convert)
      puts out
    end
    out
  end

  def build_text_units(baseQuant, isLiquid, multiplier = 1, convert = false)
    # Breaks a base quantity into appropriately sized measures, multiplying
    #   by user-requested serving size multiplier and converting to imperial
    #   units if required.
    #
    # Ex: A recipe has a line item for olive oil, with base quantity
    #     of 50 mL. The user requests 4-person serving size and imperial
    #     units.
    #     baseQuant = 50mL, isLiquid = true, multiplier = 4, convert = true
    #     
    # conversions[isLiquid][convertToImperial?]
    conversions = {true => {true => [
                                      {:factor => 48, :unit => "cups"},
                                      {:factor => 3, :unit => "Tbsp"},
                                      {:factor => 1, :unit => "tsp"} ],
                            false => [
                                      {:factor => 1000, :unit => "liters"},
                                      {:factor => 1, :unit => "mL"} ] },
                  false => {true => [
                                      {:factor => 16, :unit => "lbs"},
                                      {:factor => 1, :unit => "oz"} ],
                            false => [
                                      {:factor => 1000, :unit => "kg"},
                                      {:factor => 1, :unit => "g"} ] } }

    q = baseQuant * multiplier + 0.0
    out = []
    conversions[isLiquid][convert].each do |c|
      out.append([(q - q%c[:factor])/c[:factor], c[:unit]])
      q = (q+0.0) % c[:factor]
    end
    out.reject{ |n| n[0] == 0}.map{ |x| [x[0].round, x[1]] }.join(' ')
  end

  def join_i(ing)
    join_ingredients_recipes.find_by(ingredient_id: ing.id)
  end

  def convert_name_for_title
    URI::decode(name.gsub('-', ' ').titleize)
  end

  def get_image_path
    unless card_image_path == ""
      return card_image_path
    end
    return "recipe_card_image_default.png"
  end

  def get_difficulty
    # This should probably be just a column on the recipe itself
    # - a heuristic based on things like how carefully you need to
    #   follow the recipe (meringue, souffle, most baking), and how
    #   many things you're managing at once
    return difficulty
  end

  def get_ingredient_score
    # ingredient counts will always be at least 1
    # max ingredients among all recipes is probably in the 15-20 range?
    # - so we normalize on 15 ingredients
    count = ingredients.count
    return ((9.0*((count - 1.0)/(15.0-1.0))) + 1.0).floor.to_i
  end

  def get_time_score
    # time score is from "I want to eat" to "I'm now eating"
    # minimum probably in the 5-10 minutes range (salads)
    # max probably in the 4-5 hour range (crock-pot meals on high)
    # we'll take the sum of cook+prep time (always in minutes) and 
    # normalize to the 1-10 range out of 5-300 minutes
    # - linear transformation of a variable
    # -> (newMax - newMin) * (x - oldMin)/(oldMax-oldMin) + newMin
    time = prep_time + cook_time
    return ((9.0*((time - 5.0)/(300.0-5.0))) + 1.0).floor.to_i
  end

  serialize :actions, Hash
end
