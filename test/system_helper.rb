require_relative './test_helper'
require 'rack/test'
require 'mocha/setup'

module SystemHelper
  require 'capybara/dsl'
  require 'capybara/rails'
  #require 'capybara/screenshot'
  include Capybara::DSL 
  include Rack::Test::Methods
  include TestHelper
  include Rails.application.routes.url_helpers
  include Devise::TestHelpers
  include Warden::Test::Helpers

  Warden.test_mode!

  def app
    Rails.application
  end

  def default_url_options
    { host: "cheveuxdoo.devel" }
  end

  def setup
    setup_capybara
    setup_database
  end

  def setup_database
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.start
  end

  def setup_capybara
    Capybara.javascript_driver = :selenium
    Capybara.current_driver = Capybara.javascript_driver
    Capybara.server_port = "5000"
    Capybara.run_server = true
    Capybara.default_wait_time = 4
  end

  def teardown
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end


  def log_in_with_some_username
    @user = Fabricate(:user)
    login_as(@user, :scope => :user)
  end


  def post_to_sessions_path(email, password)
    post sessions_path, session: {email: email, password: password}, format: 'json'
  end

  # Login into the app with the given user
  def stub_user_session(user)
    login_as(user)
  end

  # Remove authenticated stubs
  def unstub_user_session(user = nil)
    logout(user)
  end

  def attempt_login_with(email, password)
    user = User.find_by_email(email)

    visit new_user_session_path
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    click_button "Log in"
  end

  def submit_reset_request_with_email(email)
    visit new_password_reset_path
    within "#password-reset-form" do
      fill_in :email, with: email
      click_button t('password_resets.create')
    end
  end

  def attempt_password_reset_with(token, password, password_confirmation)
    visit password_reset_path(token)
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button t('password_resets.save')
  end

  # Handles alert and confirmation messages via Javascript
  def handle_js_confirm(accept=true)
    page.evaluate_script "window.original_confirm_function = window.confirm"
    page.evaluate_script "window.confirm = function(msg) { return #{!!accept}; }"
    yield
  ensure
    page.evaluate_script "window.confirm = window.original_confirm_function"
  end

  def wait_for_ajax
    start_time = Time.now.to_i
    yield
    until (Time.now.to_i - start_time > Capybara.default_wait_time) do
      sleep 0.5
      break if page.evaluate_script('jQuery.active === 0')
    end
  end

  def click_signout
    user_menu = find(".user.dropdown-container")
    user_menu.click
    find("#signout").click
  end

end
