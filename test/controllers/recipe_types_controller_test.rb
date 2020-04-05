require 'test_helper'

class RecipeTypesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # pretty much all actions regarding recipe_type should be blocked if
  #   not logged in and not admin

  def setup
    @user = users(:user)
    @admin = users(:admin)
    @recipe_type = recipe_types(:recipe_type)
  end

  test "should redirect index if not logged in" do
    get recipe_types_path
    assert_redirected_to root_url
  end

  test "should redirect index if not admin" do
    sign_in @user
    get recipe_types_path
    assert_redirected_to root_url
  end

  test "should redirect edit if not logged in" do
    get edit_recipe_type_path(@recipe_type)
    assert_redirected_to root_url
  end

  test "should redirect edit if not admin" do
    sign_in @user
    get edit_recipe_type_path(@recipe_type)
    assert_redirected_to root_url
  end

  test "should block create if not logged in" do
    assert_no_difference 'RecipeType.count' do
      post "/recipe_types", params: {recipe_type: {
        tag: "test2" } }
    end
    assert_redirected_to root_url
  end

  test "should block create if not admin" do
    sign_in @user
    assert_no_difference 'RecipeType.count' do
      post "/recipe_types", params: {recipe_type: {
        tag: "test2" } }
    end
    assert_redirected_to root_url
  end

  test "should allow create if admin" do
    sign_in @admin
    assert_difference 'RecipeType.count', 1 do
      post "/recipe_types", params: {recipe_type: {
        tag: "test2" } }
    end
  end

  test "should block destroy if not logged in" do
    assert_no_difference 'RecipeType.count' do
      delete "/recipe_types/#{@recipe_type.id}"
    end
  end

  test "should block destroy if not admin" do
    sign_in @user
    assert_no_difference 'RecipeType.count' do
      delete "/recipe_types/#{@recipe_type.id}"
    end
  end

  test "should allow destroy if admin" do
    sign_in @admin
    assert_difference 'RecipeType.count', -1 do
      delete "/recipe_types/#{@recipe_type.id}"
    end
  end

  test "should block update if not logged in" do
    patch recipe_type_path(@recipe_type)
    assert_redirected_to root_url
  end
  
  test "should block update if not admin" do
    sign_in @user
    patch recipe_type_path(@recipe_type)
    assert_redirected_to root_url
  end

  # not working because of user_profile assocation thing
=begin
  test "should allow update if admin" do
    sign_in @admin
    patch recipe_type_path(@recipe_type), params: {recipe_type: {
      tag: "boop"
    } }
    assert_response :success
  end
=end

end
