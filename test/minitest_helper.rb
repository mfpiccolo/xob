ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
# require "capybara/rails"
# require "minitest/rails/capybara"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:

# Uncomment for awesome colorful output
require "minitest/pride"

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end
