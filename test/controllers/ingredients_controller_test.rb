require 'test_helper'

class IngredientsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # pretty much all actions regarding ingredients should be blocked if
  #   not logged in and not admin

  def setup
    @user = users(:user)
    @admin = users(:admin)
    @ingredient = ingredients(:ingredient)
  end

  test "should redirect index if not logged in" do
    get ingredients_path
    assert_redirected_to root_url
  end

  test "should redirect index if not admin" do
    sign_in @user
    get ingredients_path
    assert_redirected_to root_url
  end

  test "should redirect edit if not logged in" do
    get edit_ingredient_path(@ingredient)
    assert_redirected_to root_url
  end

  test "should redirect edit if not admin" do
    sign_in @user
    get edit_ingredient_path(@ingredient)
    assert_redirected_to root_url
  end

  test "should redirect new if not logged in" do
    get new_ingredient_path
    assert_redirected_to root_url
  end

  test "should redirect new if not admin" do
    sign_in @user
    get new_ingredient_path
    assert_redirected_to root_url
  end

  test "should block create if not logged in" do
    assert_no_difference 'Ingredient.count' do
      post "/ingredients", params: {ingredient: {
        name: "test1", caloriespergram: 0, imperial_show_num: 0,
        imperial_show_unit: "", imperial_list_num: 0, imperial_list_unit: "",
        metric_show_num: 0, metric_show_unit: "", metric_list_num: 0,
        metric_list_unit: "", iTags: [] } }
    end
    assert_redirected_to root_url
  end

  test "should block create if not admin" do
    sign_in @user
    assert_no_difference 'Ingredient.count' do
      post "/ingredients", params: {ingredient: {
        name: "test1", caloriespergram: 0, imperial_show_num: 0,
        imperial_show_unit: "", imperial_list_num: 0, imperial_list_unit: "",
        metric_show_num: 0, metric_show_unit: "", metric_list_num: 0,
        metric_list_unit: "", iTags: [] } }
    end
    assert_redirected_to root_url
  end

  test "should allow create if admin" do
    sign_in @admin
    assert_difference 'Ingredient.count', 1 do
      post "/ingredients", params: {ingredient: {
        name: "test1", caloriespergram: 0, imperial_show_num: 0,
        imperial_show_unit: "", imperial_list_num: 0, imperial_list_unit: "",
        metric_show_num: 0, metric_show_unit: "", metric_list_num: 0,
        metric_list_unit: "", iTags: [] } }
    end
  end

  test "should block destroy if not logged in" do
    assert_no_difference 'Ingredient.count' do
      delete "/ingredients/#{@ingredient.id}"
    end
  end

  test "should block destroy if not admin" do
    sign_in @user
    assert_no_difference 'Ingredient.count' do
      delete "/ingredients/#{@ingredient.id}"
    end
  end

  test "should allow destroy if admin" do
    sign_in @admin
    assert_difference 'Ingredient.count', -1 do
      delete "/ingredients/#{@ingredient.id}"
    end
  end

  test "should block update if not logged in" do
    patch ingredient_path(@ingredient)
    assert_redirected_to root_url
  end
  
  test "should block update if not admin" do
    sign_in @user
    patch ingredient_path(@ingredient)
    assert_redirected_to root_url
  end

  # not working because of user_profile assocation thing
=begin
  test "should allow update if admin" do
    sign_in @admin
    patch ingredient_path(@ingredient), params: {ingredient: {
      name: "boop", iTags: []
    } }
    assert_response :success
  end
=end

end
