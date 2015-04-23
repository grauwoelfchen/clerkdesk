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

require "locker_room/testing_support/integration/subdomain_helpers"
require "locker_room/testing_support/integration/authentication_helpers"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
test_dir = File.dirname(__FILE__)
Dir["#{test_dir}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = test_dir + "/fixtures"
  # ActiveSupport::TestCase.fixtures :all
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  DatabaseCleaner.strategy = :truncation

  def before_setup
    super
    DatabaseCleaner.start
  end

  def after_teardown
    DatabaseCleaner.clean
    super
  end

  def self.locker_room_fixtures(*fixture_names)
    fixtures(*fixture_names.map { |name| "locker_room/#{name}" })
  end
end

# class ActionController::TestCase
#   include Controller::SubdomainHelpers
#   include Sorcery::TestHelpers::Rails::Controller
# end

Capybara.configure do |config|
  config.app_host = "http://example.org"
end

class Capybara::Rails::TestCase
  include LockerRoom::TestingSupport::Integration::SubdomainHelpers
  include LockerRoom::TestingSupport::Integration::AuthenticationHelpers

  def before_setup
    @default_host = locker_room.scope.default_url_options[:host]
    locker_room.scope.default_url_options[:host] = Capybara.app_host
    super
  end

  def after_teardown
    super
    locker_room.scope.default_url_options[:host] = @default_host
  end
end
