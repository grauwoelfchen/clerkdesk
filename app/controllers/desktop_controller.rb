class DesktopController < WorkspaceController
  before_action :reset_locale, only: :index

  def index
  end
end
