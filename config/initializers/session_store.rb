# Be sure to restart your server when you modify this file.

options = {
  key:    "_#{ENV['APP_NAME'].to_s.downcase}_session",
  domain: ENV['APP_DOMAIN']
}

options.except!(:domain) if Rails.env.test?

Rails.application.config.session_store :cookie_store, options
