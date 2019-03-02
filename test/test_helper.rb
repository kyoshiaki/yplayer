ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Returns true if a test user is logged in.
    def helper_logged_in?
      !session[:user_id].nil?
    end

    # Log in as a particular user.
    def log_in_as(user, password: 'adminuser', remember_me: '1')
      post login_path, params: { session: { name: user.name, password: password, remember_me: remember_me } }
    end
  end
end
