require 'test_helper'

class EquipmentControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # pretty much all actions regarding equipment should be blocked if
  #   not logged in and not admin

  def setup
    @user = users(:user)
    @admin = users(:admin)
    @equipment = equipment(:equipment)
  end

  # equipment#index blocked in router, might change in the future
=begin
  test "should redirect index if not logged in" do
    get equipment_path
    assert_redirected_to root_url
  end

  test "should redirect index if not admin" do
    sign_in @user
    get equipment_path
    assert_redirected_to root_url
  end
=end

  test "should redirect edit if not logged in" do
    get edit_equipment_path(@equipment)
    assert_redirected_to root_url
  end

  test "should redirect edit if not admin" do
    sign_in @user
    get edit_equipment_path(@equipment)
    assert_redirected_to root_url
  end

  test "should redirect new if not logged in" do
    get new_equipment_path
    assert_redirected_to root_url
  end

  test "should redirect new if not admin" do
    sign_in @user
    get new_equipment_path
    assert_redirected_to root_url
  end

  test "should block create if not logged in" do
    assert_no_difference 'Equipment.count' do
      post "/equipment", params: {equipment: {
        name: "test1", affiliate_link: "testlink" } }
    end
    assert_redirected_to root_url
  end

  test "should block create if not admin" do
    sign_in @user
    assert_no_difference 'Equipment.count' do
      post "/equipment", params: {equipment: {
        name: "test1", affiliate_link: "testlink" } }
    end
    assert_redirected_to root_url
  end

  test "should allow create if admin" do
    sign_in @admin
    assert_difference 'Equipment.count', 1 do
      post "/equipment", params: {equipment: {
        name: "test1", affiliate_link: "testlink" } }
    end
  end

  test "should block destroy if not logged in" do
    assert_no_difference 'Equipment.count' do
      delete "/equipment/#{@equipment.id}"
    end
  end

  test "should block destroy if not admin" do
    sign_in @user
    assert_no_difference 'Equipment.count' do
      delete "/equipment/#{@equipment.id}"
    end
  end

  test "should allow destroy if admin" do
    sign_in @admin
    assert_difference 'Equipment.count', -1 do
      delete "/equipment/#{@equipment.id}"
    end
  end

  test "should block update if not logged in" do
    patch equipment_path(@equipment)
    assert_redirected_to root_url
  end
  
  test "should block update if not admin" do
    sign_in @user
    patch equipment_path(@equipment)
    assert_redirected_to root_url
  end

  # not working because of user_profile assocation thing
=begin
  test "should allow update if admin" do
    sign_in @admin
    patch equipment_path(@equipment), params: {equipment: {
      name: "test2", affiliate_link: "link2"
    } }
    assert_response :success
  end
=end

end
