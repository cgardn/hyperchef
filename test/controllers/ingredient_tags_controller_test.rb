require 'test_helper'

class IngredientTagsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # pretty much all actions regarding ingredient_tag should be blocked if
  #   not logged in and not admin

  def setup
    @user = users(:user)
    @admin = users(:admin)
    @ingredient_tag = ingredient_tags(:ingredient_tag)
  end

  test "should redirect index if not logged in" do
    get ingredient_tags_path
    assert_redirected_to root_url
  end

  test "should redirect index if not admin" do
    sign_in @user
    get ingredient_tags_path
    assert_redirected_to root_url
  end

  test "should redirect edit if not logged in" do
    get edit_ingredient_tag_path(@ingredient_tag)
    assert_redirected_to root_url
  end

  test "should redirect edit if not admin" do
    sign_in @user
    get edit_ingredient_tag_path(@ingredient_tag)
    assert_redirected_to root_url
  end

  test "should block create if not logged in" do
    assert_no_difference 'IngredientTag.count' do
      post "/ingredient_tags", params: {ingredient_tag: {
        tag: "test2" } }
    end
    assert_redirected_to root_url
  end

  test "should block create if not admin" do
    sign_in @user
    assert_no_difference 'IngredientTag.count' do
      post "/ingredient_tags", params: {ingredient_tag: {
        tag: "test2" } }
    end
    assert_redirected_to root_url
  end

  test "should allow create if admin" do
    sign_in @admin
    assert_difference 'IngredientTag.count', 1 do
      post "/ingredient_tags", params: {ingredient_tag: {
        tag: "test2" } }
    end
  end

  test "should block destroy if not logged in" do
    assert_no_difference 'IngredientTag.count' do
      delete "/ingredient_tags/#{@ingredient_tag.id}"
    end
  end

  test "should block destroy if not admin" do
    sign_in @user
    assert_no_difference 'IngredientTag.count' do
      delete "/ingredient_tags/#{@ingredient_tag.id}"
    end
  end

  test "should allow destroy if admin" do
    sign_in @admin
    assert_difference 'IngredientTag.count', -1 do
      delete "/ingredient_tags/#{@ingredient_tag.id}"
    end
  end

  test "should block update if not logged in" do
    patch ingredient_tag_path(@ingredient_tag)
    assert_redirected_to root_url
  end
  
  test "should block update if not admin" do
    sign_in @user
    patch ingredient_tag_path(@ingredient_tag)
    assert_redirected_to root_url
  end

  # not working because of user_profile assocation thing
=begin
  test "should allow update if admin" do
    sign_in @admin
    patch ingredient_tag_path(@ingredient_tag), params: {ingredient_tag: {
      tag: "boop"
    } }
    assert_response :success
  end
=end

end
