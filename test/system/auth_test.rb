require_relative '../system_helper'

describe "authorization" do
  include SystemHelper

  let(:user) { Fabricate :user, password: "password", password_confirmation: "password" }
  let(:disabled_user) { Fabricate :user, password: "password", password_confirmation: "password", active: false }

  describe "User authentication" do

    it "directs you to the welcome page on login without redirect_to" do
      visit new_user_session_path
      attempt_login_with(user.email, "password")
      assert has_content? "Welcome to School Uniform Resale"
    end

  #   it "shows error message with invalid login" do
  #     visit ideas_path
  #     attempt_login_with(user.email, "wrongpassword")
  #     assert has_content? t('flash.errors.login_failure')
  #   end

  #   it "disables login ability if a user is not active" do
  #     visit ideas_path
  #     attempt_login_with(disabled_user.email, "password")
  #     assert has_content? t('flash.errors.disabled')
  #   end

  #   it "signs the user out and redirects then to the login page when clicking signout" do
  #     stub_user_session(user)
  #     visit ideas_path

  #     click_signout
  #     assert has_content? "Sign in"
  #   end
  end
end
