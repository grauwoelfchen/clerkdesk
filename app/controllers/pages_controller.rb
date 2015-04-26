class PagesController < WorkspaceController
  skip_filter :require_login

  def index
  end
end
