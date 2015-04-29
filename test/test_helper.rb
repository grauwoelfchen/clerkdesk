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
    Apartment::Tenant.reset
    # DROP SCHEMA
    LockerRoom::Account.all.map do |account|
      Apartment::Tenant.drop(account.schema_name)
    rescue
      nil
    end
    DatabaseCleaner.clean
    super
  end
end

class ActionController::TestCase
  include LockerRoom::Testing::Controller::SubdomainHelpers
  include LockerRoom::Testing::Controller::AuthenticationHelpers
end

Capybara.configure do |config|
  config.app_host = "http://example.org"
end

class Capybara::Rails::TestCase
  include LockerRoom::Testing::Integration::SubdomainHelpers
  include LockerRoom::Testing::Integration::AuthenticationHelpers
end
