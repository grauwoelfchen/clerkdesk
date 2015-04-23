source "https://rubygems.org"

gem "foreman"

gem "rails", "4.2.1"
gem "pg"

gem "uglifier"
gem "slim"
gem "stylus"

gem "locker_room", path: "../locker_room"

group :doc do
  gem "sdoc", "~> 0.4.0"
end

group :development do
  gem "slim-rails"
end

group :test do
  gem "minitest", "~> 5.5"
  gem "minitest-rails-capybara"
  gem "database_cleaner"
end

rock = File.expand_path("../Gemfile.rock", __FILE__)
eval File.read(rock) if File.exists?(rock)
