# Be sure to restart your server when you modify this file.

options = {
  key:    '_clerkdesk_session',
  domain: ENV['APP_DOMAIN']
}

options.except!(:domain) if Rails.env.test?

Rails.application.config.session_store :cookie_store, options
