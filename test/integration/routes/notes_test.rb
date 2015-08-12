require 'test_helper'

class NotesRouteTest < ActionDispatch::IntegrationTest
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:notes, :people)

  def test_route_to_notes
    within_subdomain_host do |host|
      assert_routing({
        method: 'get',
        path:   "#{host}/notes"
      }, {
        controller: 'notes',
        action:     'index'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/notes?tag=ice"
      }, {
        controller: 'notes',
        action:     'index'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/notes?column=title&direction=desc&tag=ice"
      }, {
        controller: 'notes',
        action:     'index'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/notes/new"
      }, {
        controller: 'notes',
        action:     'new'
      })
      assert_routing({
        method: 'post',
        path:   "#{host}/notes"
      }, {
        controller: 'notes',
        action:     'create'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/notes/1"
      }, {
        controller: 'notes',
        action:     'show',
        id:         '1'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/notes/1/edit"
      }, {
        controller: 'notes',
        action:     'edit',
        id:         '1'
      })
      assert_routing({
        method: 'patch',
        path:   "#{host}/notes/1"
      }, {
        controller: 'notes',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'put',
        path:   "#{host}/notes/1"
      }, {
        controller: 'notes',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'delete',
        path:   "#{host}/notes/1"
      }, {
        controller: 'notes',
        action:     'destroy',
        id:         '1'
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
