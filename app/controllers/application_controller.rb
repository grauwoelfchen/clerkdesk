class ApplicationController < ActionController::Base
  include Localization

  protect_from_forgery :with => :exception

  before_filter :require_login

  layout "public"

  private

  def redirect_back_or_to(default_url, flash_hash = {})
    url = session[:return_to_url] || request.referrer || default_url
    redirect_to(url, flash: flash_hash)
  end
end
