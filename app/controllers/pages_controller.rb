class PagesController < ApplicationController
  skip_filter :require_login

  layout "public"

  def index
  end
end
