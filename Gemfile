source 'https://rubygems.org'

ruby '2.4.1'

gem 'rails', '~> 5.1.0'

gem 'pg'

gem 'locker_room', git: 'https://gitlab.com/grauwoelfchen/locker_room.git'
#gem 'locker_room'

gem 'acts-as-taggable-on', git: 'https://github.com/mbleigh/acts-as-taggable-on.git', ref: '9bb57384'
#gem 'acts-as-taggable-on', '~> 4.0'

gem 'public_activity'
gem 'friendly_id'

gem 'countries'
gem 'country_select'

gem 'rails-i18n', '~> 5.0.0'
gem 'active_link_to'
gem 'gretel'
gem 'redcarpet'
gem 'kaminari'

gem 'browserify-rails'
gem 'uglifier'

gem 'slim'
gem 'stylus'

gem 'jbuilder'
gem 'foreman', group: [:development, :test]

gem 'sdoc', '~> 0.4.2', group: [:doc]

group :production do
  gem 'puma'
end

group :development do
  gem 'slim-rails'
  gem 'spring'
end

group :test do
  gem 'sinatra', '2.0.0.beta2'

  gem 'minitest', '~> 5.10.1'
  gem 'minitest-rails-capybara'
  gem 'rails-controller-testing'
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
