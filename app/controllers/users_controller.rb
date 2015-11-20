class UsersController < WorkspaceController
  before_action :set_user, only: [:show]

  def index
    @users = current_team.mates
      .order_by(params[:field], params[:direction])
      .page(params[:page])
  end

  def show
  end

  private

  def set_user
    @user = current_team.mates.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
