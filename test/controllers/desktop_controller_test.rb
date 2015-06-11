require "test_helper"

class DesktopControllerTest < ActionController::TestCase
  locker_room_fixtures("accounts", "members", "users")

  def test_should_get_index
    user = locker_room_users(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      get :index
      assert_response :success
    end
  end
end
