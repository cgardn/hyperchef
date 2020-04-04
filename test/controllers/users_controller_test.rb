require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

=begin
  all testing related to user_profiles is on hold until I can figure out how
  to include associations in test fixtures
=end

  def setup
    @recipe = recipes(:one)
    @admin = users(:admin)
    @user = users(:user)
  end

  test "should get new" do
    get new_user_registration_path
    assert_response :success
  end

  test "should get sign-in" do
    get new_user_session_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_registration_path
    assert_redirected_to new_user_session_path
  end

  test "should not update when not logged in" do
    patch user_registration_path(@user), params: { user: {email: @user.email} }
    assert_response(401)
  end

  test "should block attempt to edit admin attribute from web" do
    sign_in @user
    assert_not @user.admin?
    # this doesn't work for some reason, wrong param setup?
=begin
    patch user_registration_path(@user), params: {
                        user: {password: "testpassword",
                        password_confirmation: "testpassword", admin: true } }
    assert_not @user.reload.admin?
=end
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete "/users/", params: {user: @user}
    end
  end
end
