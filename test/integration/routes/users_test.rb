require "test_helper"

class UsersRouteTest < ActionDispatch::IntegrationTest
  locker_room_fixtures(:teams, :users, :memberships)

  def test_route_to_users
    within_subdomain_host do |host|
      assert_routing({
        method: "get",
        path:   "#{host}/users"
      }, {
        controller: "users",
        action:     "index"
      })
      assert_routing({
        method: "get",
        path:   "#{host}/users/1"
      }, {
        controller: "users",
        action:     "show", id: "1"
      })
    end
  end

  private

  def within_subdomain_host
    user = locker_room_users(:oswald)
    host = "http://#{user.team.subdomain}.example.org"
    yield(host)
  end
end
