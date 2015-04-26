class ApplicationController < ActionController::Base
  protect_from_forgery :with => :exception

  before_filter :require_login

  layout "public"
end
