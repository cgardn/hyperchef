require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # user-facing recipe actions
  #  - admin recipe actions (create, edit, destroy) in admin controller test

  def setup
    @recipe = recipes(:one)
    @user = users(:user)
    @admin = users(:admin)
  end

  test "should get show page" do
    get recipe_path(@recipe)
    assert_response :success
  end

  test "should redirect destroy if not logged in" do
    assert_no_difference 'Recipe.count' do
      delete "/recipes/#{@recipe.slug}"
    end
  end

  test "should redirect destroy if not admin" do
    sign_in @user
    assert_no_difference 'Recipe.count' do
      delete "/recipes/#{@recipe.slug}"
    end
  end

  test "should destroy if admin" do
    sign_in @admin
    assert_difference 'Recipe.count', -1 do
      delete "/recipes/#{@recipe.slug}", params: {slug: @recipe.slug}
    end
  end

  test "should redirect create if not logged in" do
    assert_no_difference 'Recipe.count' do
      post "/recipes", params: { recipe: @recipe }
    end
  end

  test "should redirect create if not admin" do
    sign_in @user
    assert_no_difference 'Recipe.count' do
      post "/recipes", params: { recipe: @recipe }
    end
  end

  # write out whole params hash here, because I haven't figured out
  #  associations on test fixtures yet
  test "should create if admin" do
    sign_in @admin
    assert_difference 'Recipe.count', 1 do
      post "/recipes", params: { recipe: {
        slug: "test2-recipe", name: "Test2 Recipe", origin: "", author: "",
        actions: [ ["1","2"], ["3","4"] ], card_image_path: "",
        views: 0, saves: 0, cook_time: 0, prep_time: 0, difficulty: 0,
        time_score: 0, ingredient_score: 0, rTypes: [], equipment: [],
        ingredients: [] } }
    end
  end

  test "should redirect edit if not logged in" do
    get edit_recipe_path(@recipe)
    assert_redirected_to root_url
  end

  test "should redirect edit if not admin" do
    sign_in @user
    get edit_recipe_path(@recipe)
    assert_redirected_to root_url
  end

  # another broken test because of test fixture association stuff for 
  #   admin's user_profile >:(
=begin
  test "should get edit if admin" do
    sign_in @admin
    get edit_recipe_path(@recipe)
    assert_response :success
  end
=end

end
