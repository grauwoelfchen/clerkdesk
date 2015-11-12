module Settings
  class UsersController < WorkspaceController
    before_action :set_user

    def edit
    end

    def update
      @user.skip_password = true
      if @user.update_attributes(user_params)
        session.delete(:locale) if user_params[:locale]
        redirect_to(user_settings_url,
          :notice => 'Account has been successfully updated.')
      else
        flash.now[:alert] = 'Account could not be updated.'
        render(:edit)
      end
    end

    private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:name, :locale)
    end
  end
end
