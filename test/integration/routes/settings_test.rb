require 'test_helper'

class SettingsRouteTest < ActionDispatch::IntegrationTest 
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:'finance/ledgers', :'finance/budgets', :'finance/accounts',
           :'finance/entries', :'finance/categories', :'finance/categories')

  def test_route_to_finance_ledgers
    within_subdomain_host do |host|
      assert_routing({
        method: 'get',
        path:   "#{host}/settings/account"
      }, {
        controller: 'settings/users',
        action:     'edit'
      })
      assert_routing({
        method: 'patch',
        path:   "#{host}/settings/account"
      }, {
        controller: 'settings/users',
        action:     'update'
      })
      assert_routing({
        method: 'put',
        path:   "#{host}/settings/account"
      }, {
        controller: 'settings/users',
        action:     'update'
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
