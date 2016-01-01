ENV['RAILS_ENV'] ||= 'test'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

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
require 'public_activity/testing'

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
    # load normal fixtures
    super
  end

  def after_teardown
    #super
    DatabaseCleaner.clean
    Apartment::Tenant.reset
  end
end

class ActionController::TestCase
  include LockerRoom::Testing::Controller::WardenHelpers
  include LockerRoom::Testing::Controller::SubdomainHelpers
  include LockerRoom::Testing::Controller::AuthenticationHelpers
end

# NOTE
# host and subdomain handling depend tld_length in environments/test.rb
# foo.127.0.0.1.xip.io
#
# * Rails.application.config.action_dispatch.tld_length
# * ActionDispatch::Http::URL.tld_length

# Capybara

RACK_HOST = '127.0.0.1.xip.io:3000'
JS_HOST   = '127.0.0.1.xip.io:3001'

ENV['BRAINTREE_GATEWAY_PORT'] ||= '45678'

require 'fake_braintree'
FakeBraintree.activate!(gateway_port: ENV['BRAINTREE_GATEWAY_PORT'])

# https://github.com/highfidelity/fake_braintree/issues/18#issuecomment-13776245
class PortMap
  def initialize(default_app, mappings)
    @default_app = default_app
    @mappings = mappings
  end

  def call(env)
    request = Rack::Request.new(env)
    port = request.port
    app = @mappings[port] || @default_app
    app.call(env)
  end
end

original_app = Capybara.app

Capybara.app = PortMap.new(
  original_app,
  ENV['BRAINTREE_GATEWAY_PORT'].to_i => FakeBraintree::SinatraApp
)

Capybara.configure do |config|
  config.app_host              = "http://#{RACK_HOST}"
  config.run_server            = true
  config.always_include_port   = true
  config.default_max_wait_time = 6 # seconds (default: 2)
end

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app,
    :headers => {'HTTP_ACCEPT_LANGUAGE' => 'en'})
end

Capybara.register_driver :poltergeist do |app|
  phantomjs_path = '../../node_modules/.bin/phantomjs'
  Capybara::Poltergeist::Driver.new(app,
    :timeout           => 90, # seconds (default: 30)
    :debug             => ENV['TEST_DEBUG'],
    :js_errors         => true,
    :phantomjs         => File.expand_path(phantomjs_path, __FILE__),
    :phantomjs_logger  => $stdout,
    :phantomjs_options => [
      '--local-to-remote-url-access=yes',
      '--script-encoding=utf8',
      "--proxy=#{JS_HOST}",
      '--proxy-type=http',
      '--load-images=no',
      '--ignore-ssl-errors=yes',
      '--ssl-protocol=TLSv1'
    ])
end

class Capybara::Rails::TestCase
  include LockerRoom::Testing::Integration::SubdomainHelpers
  include LockerRoom::Testing::Integration::AuthenticationHelpers
  include Integration

  def before_setup
    FakeBraintree.clear!
    super
  end
end
