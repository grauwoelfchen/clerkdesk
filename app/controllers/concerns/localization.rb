module Localization
  extend ActiveSupport::Concern

  included do
    before_action :set_locale

    def current_locale
      session[:locale]
    end
    helper_method :current_locale

    private

    # helper methods

    def available_locales
      Rails.application.config.i18n.available_locales.map(&:to_s)
    end

    def valid_locale(detected_locale)
      detected_locale.in?(available_locales) ? detected_locale.intern : nil
    end

    def extract_lang_from_http_accept_language
      request.env["HTTP_ACCEPT_LANGUAGE"].to_s.scan(/^[a-z]{2}/).first
    end

    def accept_lang
      valid_locale(extract_lang_from_http_accept_language)
    end

    def user_locale
      current_user ? valid_locale(current_user.locale) : nil
    end

    # actions

    def set_locale
      session[:locale] ||= (user_locale || accept_lang || I18n.default_locale)
      I18n.locale = session[:locale]
    end

    def reset_locale
      session.delete(:locale)
      set_locale
    end
  end
end
