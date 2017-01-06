class ApplicationController < ActionController::Base
  include Localization

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  layout Proc.new { |c|
    request.path !~ /\A\/sign(up|in|out)/i &&
    c.send(:current_team) && c.send(:current_user) ? 'application' : 'public' }

  private

  def redirect_back_or_to(default_url, flash_hash={})
    url = session.delete(:return_to_url) || request.referrer || default_url
    redirect_to(url, :flash => flash_hash)
  end
end
