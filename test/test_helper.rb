ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
ActiveRecord::Migrator.migrations_paths = [
  File.expand_path('../../db/migrate', __FILE__)
]
require 'rails/test_help'

require "minitest/mock"
require "minitest/rails/capybara"
require "minitest/pride" if ENV["TEST_PRIDE"].present?
require "database_cleaner"

Minitest.backtrace_filter = Minitest::BacktraceFilter.new

Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  include LockerRoom::Testing::FixtureHelpers

  ActiveRecord::Migration.check_pending!
  DatabaseCleaner.clean_with(:truncation)
  DatabaseCleaner.strategy = :transaction

  def before_setup
    super
    DatabaseCleaner.start
  end

  def after_teardown
    DatabaseCleaner.clean
    Apartment::Tenant.reset
    clean_all_schema
    super
  end

  def clean_all_schema
    LockerRoom::Account.all.map do |account|
      conn = ActiveRecord::Base.connection
      conn.query(%Q{DROP SCHEMA IF EXISTS #{account.schema_name} CASCADE;})
    end
  end
end

class ActionController::TestCase
  include LockerRoom::Testing::Controller::SubdomainHelpers
  include LockerRoom::Testing::Controller::AuthenticationHelpers
end

Capybara.configure do |config|
  config.app_host = "http://example.org"
end

Capybara.register_driver :rack_test do |app|
  headers = {"HTTP_ACCEPT_LANGUAGE" => "en"}
  Capybara::RackTest::Driver.new(app, headers: headers)
end

class Capybara::Rails::TestCase
  include LockerRoom::Testing::Integration::SubdomainHelpers
  include LockerRoom::Testing::Integration::AuthenticationHelpers
end
