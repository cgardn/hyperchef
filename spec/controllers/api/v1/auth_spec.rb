require 'rails_helper'

RSpec.describe Api::V1::AuthsController do

  describe "GET #check_admin as user" do
    before do
      get :check_admin
    end

    let (:user) {ApiUser.create(email: "test@test.test", password: "password", admin: false)}

    it "returns 401" do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET #check_admin as admin" do
    before do
      get :check_admin, params: {user: user, password: user.password}
    end

    let (:user) {ApiUser.create(email: "test@test.test", password: "password", admin: true)}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
