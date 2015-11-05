require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  locker_room_fixtures(:teams, :users, :mateships)

  def test_get_index
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      get(:index)
      refute_empty(assigns[:users])
      assert_template(:index)
      assert_response(:success)
    end
  end

  def test_get_show
    user = locker_room_users(:oswald)
    team = user.teams.first
    within_subdomain(team.subdomain) do
      login_user(user)
      user = locker_room_users(:weenie)
      get(:show, :id => user.id)
      assert_equal(user, assigns[:user])
      assert_template(:show)
      assert_response(:success)
    end
  end
end
