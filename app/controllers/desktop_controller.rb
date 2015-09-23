class DesktopController < WorkspaceController
  before_action :set_activities, only: :index
  before_action :reset_locale,   only: :index

  def index
  end

  private

  def set_activities
    @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
  end
end
