require 'test_helper'

class SnippetsRouteTest < ActionDispatch::IntegrationTest
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:snippets, :contacts)

  def test_route_to_snippets
    within_subdomain_host do |host|
      assert_routing({
        method: 'get',
        path:   "#{host}/snippets"
      }, {
        controller: 'snippets',
        action:     'index'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/snippets?tag=ice"
      }, {
        controller: 'snippets',
        action:     'index'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/snippets?column=title&direction=desc&tag=ice"
      }, {
        controller: 'snippets',
        action:     'index'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/snippets/new"
      }, {
        controller: 'snippets',
        action:     'new'
      })
      assert_routing({
        method: 'post',
        path:   "#{host}/snippets"
      }, {
        controller: 'snippets',
        action:     'create'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/snippets/1"
      }, {
        controller: 'snippets',
        action:     'show',
        id:         '1'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/snippets/1/edit"
      }, {
        controller: 'snippets',
        action:     'edit',
        id:         '1'
      })
      assert_routing({
        method: 'patch',
        path:   "#{host}/snippets/1"
      }, {
        controller: 'snippets',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'put',
        path:   "#{host}/snippets/1"
      }, {
        controller: 'snippets',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'delete',
        path:   "#{host}/snippets/1"
      }, {
        controller: 'snippets',
        action:     'destroy',
        id:         '1'
      })
    end
  end

  private

  def within_subdomain_host
    user = locker_room_users(:oswald)
    team = user.teams.first
    host = "http://#{team.subdomain}.#{RACK_HOST}"
    yield(host)
  end
end
