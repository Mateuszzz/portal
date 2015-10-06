ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def logged_in?
    !session[:user_id].nil?
  end
  
  def log_in_as(user)
    if defined?(post_via_redirect)
      post login_path, email: user.email, password: "password"
    else
      session[:user_id] = user.id
    end
  end
end
