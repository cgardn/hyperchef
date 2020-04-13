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
    # it_new = IngredientTag.joins(ingredients: :recipes).where("recipe_id = ?", id).pluck(:name).flatten.uniq
    rt = recipe_types.pluck(:name)
    it = IngredientTag.joins(ingredients: :recipes).where("recipe_id = ?", id).pluck(:name).flatten.uniq
    rt + it
  end

  # not used
  def set_quantity(ing, amt)
    ingquant = join_ingredients_recipes.find_by(ingredient_id: Ingredient.find_by(name: ing))
    ingquant.quantity_in_grams = amt
    ingquant.save
  end

  # not used
  def edit_quants
    out = {}
    join_ingredients_recipes.each do |i|
      ingredient = Ingredient.find(i.ingredient_id)
      out[ingredient.name] = [i.quantity_in_grams, ingredient.is_liquid]
    end
    out
  end

  # not used
  def ing_quants(convert = false, multiplier = 1)
    if convert.nil? || convert == "false"
      convert = false
    elsif convert == "true"
      convert = true
    end
    puts "Convert: "
    p convert
    puts "Multiplier: "
    p multiplier
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

  # can modify to use with new show_unit/list_unit system on ingredients,
  #   call this from controller when building views for recipe#show as well as
  #   grocery#show (grocery list not implemented yet)
  #   - but the new show/list system has conversions baked in?
  #   - still need to break down into larger units though, so I can adapt this
  #     to that purpose using the ingredient's given unit ('mL', 'oz', etc)

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
    #     q = baseQuant * servings
    #     convert to imperial if necessary: g to oz, ml to tsp.
    #       (round tsp to nearest 1/4 cup, if below 1/4 cup round to nearest tbsp
    #        if below 1 tbsp, round to nearest tsp)
    #     then sort into larger units with modulo div
    #
    #     50 mL * 4 servings = 200mL
    #     convert to Imperial? yes -> 200 mL = 40.8 tsp
    #     sort into larger units:
    #       40.8 tsp = 0.84 cups, round to 0.75 cups
    #     
    # conversions[isLiquid][convertToImperial?]

    q = baseQuant * multiplier
    
    conversions = {true => {true =>  [0.203,
                                     [
                                      {:factor => 48, :unit => "cups"},
                                      {:factor => 3, :unit => "Tbsp"},
                                      {:factor => 1, :unit => "tsp"} ]],
                            false => [1,
                                     [
                                      {:factor => 1000, :unit => "liters"},
                                      {:factor => 1, :unit => "mL"} ]] },
                   false => {true => [0.035,
                                     [
                                      {:factor => 16, :unit => "lbs"},
                                      {:factor => 1, :unit => "oz"} ]],
                            false => [1,
                                     [
                                      {:factor => 1000, :unit => "kg"},
                                      {:factor => 1, :unit => "g"} ]] } }

    q = baseQuant * multiplier + 0.0
    q = conversions[isLiquid][convert][0] * q 
    out = []
    conversions[isLiquid][convert][1].each do |c|
      out.append([(q - q%c[:factor])/c[:factor], c[:unit]])
      q = (q+0.0) % c[:factor]
    end
    out.reject{ |n| n[0] == 0}.map{ |x| [x[0].round, x[1]] }.join(' ')
  end

  # not used
  def join_i(ing)
    join_ingredients_recipes.find_by(ingredient_id: ing.id)
  end

  # not used, use slugs and separate name now
  def convert_name_for_title
    URI::decode(name.gsub('-', ' ').titleize)
  end

  # not used, but might in the future
  def get_image_path
    unless card_image_path == ""
      return card_image_path
    end
    return "recipe_card_image_default.png"
  end

  def get_bartype(score)
    # returns a string specifying the class of bootstrap progress bar
    # - based on bootstrap colors for progress bars
    # - 1-4 green
    # - 5-7 yellow
    # - 8-10 red
    ['success','success','success','success',
     'warning','warning','warning',
     'danger','danger','danger'][score-1]
  end

  def normalize(input, oldMin, oldMax, newMin, newMax)
    newMin + (newMax - newMin)*( (input - oldMin)/(oldMax - oldMin) )
  end

  serialize :actions, Hash
end
