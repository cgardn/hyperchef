require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @recipe = Recipe.new(
      slug: "test2-recipe",
      name: "Test2 Recipe",
      origin: "",
      author: "",
      actions: [ ["1","2"], ["3","4"] ],
      card_image_path: "",
      views: 0,
      saves: 0,
      cook_time: 0,
      prep_time: 0,
      difficulty: 0,
      time_score: 0,
      ingredient_score: 0,
      rTypes: [],
      equipment: [],
      ingredients: [] )
  end
end
