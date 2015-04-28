require 'test_helper'

class DesktopControllerTest < ActionController::TestCase
  locker_room_fixtures("users")

  #def setup
  #  #@request.host = "piano.example.org"
  #end

  def test_should_get_index
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      get :index
      assert_response :success
    end
  end
end
