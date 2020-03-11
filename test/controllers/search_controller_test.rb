require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest

  def setup
    @recipecount = Recipe.all.count
  end


  test "should get main page" do
    get root_url
    assert_response :success
  end

  test "blank query should return all recipes" do
    get search_path
    all_recipes = Recipe.all
    all_recipes.each do |recipe|
      assert_select 'a[href=?]', recipe_path(recipe), count: 1
    end
  end

end
