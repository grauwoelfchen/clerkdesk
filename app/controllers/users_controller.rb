class UsersController < WorkspaceController
  before_action :load_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = LockerRoom::User.all
  end

  def show
  end

  private

  def load_user
    @user = LockerRoom::User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
