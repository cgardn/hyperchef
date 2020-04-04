require 'test_helper'

class UserProfilesControllerTest < ActionDispatch::IntegrationTest
  # User profiles in this app are only join tables holding references
  # to favorite recipes. This is because I'm using Devise for user accounts
  # and I wanted to keep the devise stuff "pure."
  #
  # To that end, the only thing that should be tested here is #show, since
  # that's the page that lists favorites. Even user_profile creation is 
  # handled in the users controller (the only code I added to devise)
  # deletion of user profile tested in user also
  # setup do
  #   @profile = user_profiles(:userprofile)
  # end
  # 
  #   test "should show user_profile" do
  #     puts user_profile_url(@profile)
  #     get user_profile_url(@profile)
  #     assert_response :success
  #   end
end
