require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @recipe = Recipe.new(
      slug: "test2-recipe",
      name: "Test2 Recipe",
      origin: "",
      author: "",
      actions: {0 => ["1","2"], 1=> ["3","4"] },
      card_image_path: "test.png",
      views: 0,
      saves: 0,
      cook_time: 0,
      prep_time: 0,
      difficulty: 0,
      time_score: 0,
      ingredient_score: 0)
    @ingredient = Ingredient.new(
      is_liquid: false,
      name: "fakeingredient",
      caloriespergram: 10)

      
  end

  test "to_param should return slug" do
    assert @recipe.to_param == "test2-recipe"
  end

  test "get_image_path should return image path" do
    assert @recipe.get_image_path == "test.png"
  end

  test "get_image_path should return default if no image path" do
    @recipe.card_image_path = ""
    assert @recipe.get_image_path == "recipe_card_image_default.png"
  end

  
end
