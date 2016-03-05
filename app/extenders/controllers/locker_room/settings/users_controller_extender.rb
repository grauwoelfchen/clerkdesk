::LockerRoom::Settings::UsersController.class_eval do
  private

  def user_params
    params.require(:user).permit(
      :name, :locale,
      # optional
      #:password, :password_confirmation
    )
  end
end
