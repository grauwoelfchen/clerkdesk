require 'test_helper'

class DesktopControllerTest < ActionController::TestCase
  locker_room_fixtures("users")

  test "should get index" do
    user = locker_room_users(:oswald)
    within_subdomain(user.account.subdomain) do
      get :index
      assert_response :success
    end
  end
end
