require 'test_helper'

class SettingsRouteTest < ActionDispatch::IntegrationTest
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:'finance/ledgers', :'finance/budgets', :'finance/accounts',
           :'finance/entries', :'finance/categories', :'finance/categories')

  def test_route_to_users
    within_subdomain_host do |host|
      at_locker_room do
        assert_routing({
          method: 'get',
          path:   "#{host}/settings/user"
        }, {
          controller: 'locker_room/settings/users',
          action:     'edit'
        })
        assert_routing({
          method: 'patch',
          path:   "#{host}/settings/user"
        }, {
          controller: 'locker_room/settings/users',
          action:     'update'
        })
        assert_routing({
          method: 'put',
          path:   "#{host}/settings/user"
        }, {
          controller: 'locker_room/settings/users',
          action:     'update'
        })
      end
    end
  end

  def test_route_to_passwords
    within_subdomain_host do |host|
      at_locker_room do
        assert_routing({
          method: 'get',
          path:   "#{host}/settings/password"
        }, {
          controller: 'locker_room/settings/passwords',
          action:     'edit'
        })
        assert_routing({
          method: 'patch',
          path:   "#{host}/settings/password"
        }, {
          controller: 'locker_room/settings/passwords',
          action:     'update'
        })
        assert_routing({
          method: 'put',
          path:   "#{host}/settings/password"
        }, {
          controller: 'locker_room/settings/passwords',
          action:     'update'
        })
      end
    end
  end

  def test_route_to_teams
    within_subdomain_host do |host|
      at_locker_room do
        assert_routing({
          method: 'get',
          path:   "#{host}/settings/team"
        }, {
          controller: 'locker_room/settings/teams',
          action:     'edit'
        })
        assert_routing({
          method: 'patch',
          path:   "#{host}/settings/team"
        }, {
          controller: 'locker_room/settings/teams',
          action:     'update'
        })
        assert_routing({
          method: 'put',
          path:   "#{host}/settings/team"
        }, {
          controller: 'locker_room/settings/teams',
          action:     'update'
        })
      end
    end
  end

  def test_route_to_mates
    within_subdomain_host do |host|
      at_locker_room do
        assert_routing({
          method: 'get',
          path:   "#{host}/settings/mates"
        }, {
          controller: 'locker_room/settings/mates',
          action:     'index'
        })
      end
    end
  end

  private

  def at_locker_room
    @routes = LockerRoom::Engine.routes
    yield
    @routes = Rails.application.routes
  end

  def within_subdomain_host
    user = locker_room_users(:oswald)
    team = user.teams.first
    host = "http://#{team.subdomain}.#{RACK_HOST}"
    yield(host)
  end
end
