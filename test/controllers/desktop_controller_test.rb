require 'test_helper'

class DesktopControllerTest < ActionController::TestCase
  locker_room_fixtures(:teams, :users, :mateships)

  def test_should_get_index
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:index)
      assert_response(:success)
    end
  end
end
