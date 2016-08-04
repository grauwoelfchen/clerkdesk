source 'https://rubygems.org'

gem 'sprockets-rails', '~> 2.3'

gem 'rails', '~> 4.2.5.2'
gem 'pg'

# TODO: release locker_room gem
gem 'locker_room', git: 'https://github.com/grauwoelfchen/locker_room.git'
#gem 'locker_room', path: '../locker_room'

gem 'acts-as-taggable-on', '~> 3.4'
gem 'public_activity'
gem 'friendly_id'

gem 'countries'
gem 'country_select'

gem 'rails-i18n', '4.0.4'
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
  gem 'minitest', '~> 5.5'
  gem 'minitest-rails-capybara'
  gem 'test_after_commit'
  gem 'database_cleaner'
  gem 'connection_pool'
  gem 'poltergeist'
  gem 'fake_braintree'
  gem 'codeclimate-test-reporter', require: nil
end

# Lock the rocks!
# The additional personal Gemfile.rock support for development and test.
#
# @example
#   bundle install         #=> The rock file will be loaded if exists
#   ROCK=no bundle install #=> Ignores the rock file
group :development, :test do
  if ENV['ROCK'] !~ /\A(no|false)\z/i
    rock = File.expand_path('../Gemfile.rock', __FILE__)
    if File.exist?(rock)
      eval File.read(rock)
    end
  end
end
