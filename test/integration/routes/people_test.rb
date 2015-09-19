require 'test_helper'

class PeopleRouteTest < ActionDispatch::IntegrationTest
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:people)

  def test_route_to_people
    within_subdomain_host do |host|
      assert_routing({
        method: 'get',
        path:   "#{host}/people"
      }, {
        controller: 'people',
        action:     'index'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/people/new"
      }, {
        controller: 'people',
        action:     'new'
      })
      assert_routing({
        method: 'post',
        path:   "#{host}/people"
      }, {
        controller: 'people',
        action:     'create'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/people/1"
      }, {
        controller: 'people',
        action:     'show',
        id:         '1'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/people/1/edit"
      }, {
        controller: 'people',
        action:     'edit',
        id:         '1'
      })
      assert_routing({
        method: 'patch',
        path:   "#{host}/people/1"
      }, {
        controller: 'people',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'put',
        path:   "#{host}/people/1"
      }, {
        controller: 'people',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'delete',
        path:   "#{host}/people/1"
      }, {
        controller: 'people',
        action:     'destroy',
        id:         '1'
      })
    end
  end

  private

  def within_subdomain_host
    user = locker_room_users(:oswald)
    host = "http://#{user.team.subdomain}.#{RACK_HOST}"
    yield(host)
  end
end
