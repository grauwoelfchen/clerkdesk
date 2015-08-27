source 'https://rubygems.org'

gem 'foreman'

gem 'rails', '4.2.1'
gem 'pg'

gem 'locker_room', git: 'https://github.com/grauwoelfchen/locker_room.git'

gem 'acts-as-taggable-on', '~> 3.4'
gem 'friendly_id'
gem 'date_validator'

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

gem 'newrelic_rpm'

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :development do
  gem 'slim-rails'
end

group :test do
  gem 'minitest', '~> 5.5'
  gem 'minitest-rails-capybara'
  gem 'database_cleaner'
end

rock = File.expand_path('../Gemfile.rock', __FILE__)
eval File.read(rock) if File.exists?(rock)
