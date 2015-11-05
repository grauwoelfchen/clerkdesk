require 'test_helper'

class ContactsRouteTest < ActionDispatch::IntegrationTest
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:contacts)

  def test_route_to_contacts
    within_subdomain_host do |host|
      assert_routing({
        method: 'get',
        path:   "#{host}/contacts"
      }, {
        controller: 'contacts',
        action:     'index'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/contacts/new"
      }, {
        controller: 'contacts',
        action:     'new'
      })
      assert_routing({
        method: 'post',
        path:   "#{host}/contacts"
      }, {
        controller: 'contacts',
        action:     'create'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/contacts/1"
      }, {
        controller: 'contacts',
        action:     'show',
        id:         '1'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/contacts/1/edit"
      }, {
        controller: 'contacts',
        action:     'edit',
        id:         '1'
      })
      assert_routing({
        method: 'patch',
        path:   "#{host}/contacts/1"
      }, {
        controller: 'contacts',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'put',
        path:   "#{host}/contacts/1"
      }, {
        controller: 'contacts',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'delete',
        path:   "#{host}/contacts/1"
      }, {
        controller: 'contacts',
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
