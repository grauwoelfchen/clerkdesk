class UsersController < WorkspaceController
  before_action :set_user, only: [:show]

  def index
    @users = current_team.users
      .sort(params[:field], params[:direction])
      .page(params[:page])
  end

  def show
  end

  private

  def set_user
    @user = current_team.users.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
