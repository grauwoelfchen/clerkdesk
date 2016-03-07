module Settings
  class UsersController < WorkspaceController
    def index
      @users = current_team.mates
        .order_by(params[:field], params[:direction])
        .page(params[:page])
    end
  end
end
