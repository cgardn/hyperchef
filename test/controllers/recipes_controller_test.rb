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


end
