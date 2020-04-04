require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = users(:admin)
    @user = users(:user)
  end

  test "should redirect if not logged in" do
    get admin_path
    assert_redirected_to root_url
  end

  test "should redirect if not admin" do
    sign_in @user
    get admin_path
    assert_redirected_to root_url
  end

  # this fails because there's no user_profile attached to user fixtures,
  #   and the _header expects a user_profile to generate the link to view it.
  #   Once I can add associations to the fixtures, this should pass
=begin
  test "should get index if logged in as admin" do
    sign_in @admin
    assert_response :success
  end
=end

end
