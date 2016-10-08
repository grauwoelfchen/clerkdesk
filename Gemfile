source 'https://rubygems.org'

gem 'sprockets-rails', '2.3.1'
gem 'sprockets', '3.6.2'
gem 'rails', '~> 4.2.7.1'

gem 'pg'

# TODO: release locker_room gem
gem 'locker_room', git: 'https://github.com/grauwoelfchen/locker_room.git'
#gem 'locker_room', path: '../locker_room'

gem 'acts-as-taggable-on', '~> 4.0'
gem 'public_activity'
gem 'friendly_id'

gem 'countries'
gem 'country_select'

gem 'rails-i18n', '~> 4.0.0'
gem 'active_link_to'
gem 'gretel'
gem 'redcarpet'
gem 'kaminari'

gem 'browserify-rails'
gem 'uglifier'

gem 'jbuilder'
gem 'slim'
gem 'stylus'

gem 'foreman', group: [:development, :test]

gem 'sdoc', '~> 0.4.0', group: [:doc]

group :production do
  gem 'puma'
  gem 'rails_12factor'
end

group :development do
  gem 'slim-rails'
  gem 'spring'
end

group :test do
  gem 'sinatra', '~> 1.4.7'

  gem 'minitest', '~> 5.9.1'
  gem 'minitest-rails-capybara'
  gem 'database_cleaner'
  gem 'connection_pool'
  gem 'poltergeist'
  gem 'fake_braintree'
  gem 'codeclimate-test-reporter', require: nil
end

# Gemfile.hack:
# The additional personal Gemfile.rock support for development and test.
#
# @example
#   bundle install         #=> The .hack file will be loaded if it exists
#   HACK=no bundle install #=> Ignores the .hack file
group :development, :test do
  if ENV['HACK'] !~ /\A(no|false)\z/i
    hack = File.expand_path('../Gemfile.hack', __FILE__)
    if File.exist?(hack)
      eval File.read(hack)
    end
  end
end
