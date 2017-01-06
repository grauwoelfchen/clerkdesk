class PagesController < WorkspaceController
  skip_before_filter :require_login

  def index
  end
end
