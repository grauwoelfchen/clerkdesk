ENV['RAILS_ENV'] ||= 'test'
ENV['TEST_HOST'] ||= 'example.org:80'

require File.expand_path('../../config/environment', __FILE__)
ActiveRecord::Migrator.migrations_paths = [
  File.expand_path('../../db/migrate', __FILE__)
]

require 'rails/test_help'

require 'minitest/mock'
require 'minitest/rails/capybara'
require 'minitest/pride' if ENV['TEST_PRIDE'].present?
require 'capybara/poltergeist'
require 'database_cleaner'

Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }

include ActionDispatch::TestProcess

Minitest.backtrace_filter = Minitest::BacktraceFilter.new
Minitest.after_run {
  # clean_all_schema
  LockerRoom::Team.all.map do |team|
    conn = ActiveRecord::Base.connection
    conn.query(%Q{DROP SCHEMA IF EXISTS #{team.schema_name} CASCADE;})
  end
}

ActiveRecord::Migration.check_pending!
DatabaseCleaner.clean_with(:truncation)
DatabaseCleaner.strategy = :transaction

class ActiveSupport::TestCase
  include LockerRoom::Testing::FixtureHelpers

  def before_setup
    # default schema (see locker_room_fixtures)
    team = locker_room_teams(:playing_piano)
    if team
      result = ActiveRecord::Base.connection.execute(<<-SQL)
        SELECT schema_name
        FROM information_schema.schemata
        WHERE schema_name = '#{team.schema_name}';
      SQL
      if result.first.blank?
        team.create_schema
      end
    end
    Apartment::Tenant.switch!(team.subdomain)
    DatabaseCleaner.start
    # normal fixtures
    super
  end

  def after_teardown
    DatabaseCleaner.clean
    Apartment::Tenant.reset
    # super
  end
end

class ActionController::TestCase
  include LockerRoom::Testing::Controller::SubdomainHelpers
  include LockerRoom::Testing::Controller::AuthenticationHelpers
end

Rails.application.routes.default_url_options[:host] = ENV['TEST_HOST']

# Capybara

Capybara.configure do |config|
  config.app_host              = "http://#{ENV['TEST_HOST']}"
  config.always_include_port   = true
  config.default_max_wait_time = 6
end

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, {
    :headers => {'HTTP_ACCEPT_LANGUAGE' => 'en'}
  })
end

Capybara.register_driver :poltergeist do |app|
  phantomjs_path = '../../node_modules/.bin/phantomjs'
  Capybara::Poltergeist::Driver.new(app, {
    :timeout           => 900,
    :debug             => ENV['TEST_DEBUG'],
    :js_erros          => ENV['TEST_DEBUG'],
    :phantomjs         => File.expand_path(phantomjs_path, __FILE__),
    :phantomjs_logger  => $stdout,
    :phantomjs_options => [
      '--local-to-remote-url-access=yes',
      "--proxy=#{ENV['TEST_HOST']}",
      '--proxy-type=http',
      '--load-images=no',
      '--ignore-ssl-errors=yes',
      '--ssl-protocol=TLSv1'
    ]
  })
end

class Capybara::Rails::TestCase
  include LockerRoom::Testing::Integration::SubdomainHelpers
  include LockerRoom::Testing::Integration::AuthenticationHelpers
  include Integration
end
