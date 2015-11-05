require 'test_helper'

class FinanceRouteTest < ActionDispatch::IntegrationTest
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:'finance/reports', :'finance/budgets', :'finance/accounts',
           :'finance/entries', :'finance/categories', :'finance/categories')

  def test_route_to_finance_reports
    within_subdomain_host do |host|
      assert_routing({
        method: 'get',
        path:   "#{host}/finances"
      }, {
        controller: 'finance/reports',
        action:     'index'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/finances/new"
      }, {
        controller: 'finance/reports',
        action:     'new'
      })
      assert_routing({
        method: 'post',
        path:   "#{host}/finances"
      }, {
        controller: 'finance/reports',
        action:     'create'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/finances/1/overview"
      }, {
        controller: 'finance/reports',
        action:     'show',
        id:         '1'
      })
      assert_routing({
        method: 'get',
        path:   "#{host}/finances/1/edit"
      }, {
        controller: 'finance/reports',
        action:     'edit',
        id:         '1'
      })
      assert_routing({
        method: 'patch',
        path:   "#{host}/finances/1"
      }, {
        controller: 'finance/reports',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'put',
        path:   "#{host}/finances/1"
      }, {
        controller: 'finance/reports',
        action:     'update',
        id:         '1'
      })
      assert_routing({
        method: 'delete',
        path:   "#{host}/finances/1"
      }, {
        controller: 'finance/reports',
        action:     'destroy',
        id:         '1'
      })
      assert_raise(Minitest::Assertion) do
        assert_routing({
          method: 'get',
          path:   "#{host}/finances/1"
        }, {
          controller: 'finance/reports',
          action:     'show',
          id:         '1'
        })
      end
    end
  end

  def test_route_to_finance_journalizings
    within_subdomain_host do |host|
      assert_routing({
        method: 'get',
        path:   "#{host}/finances/1/accounts/1/journalizings.json?type=income"
      }, {
        controller: 'finance/journalizings',
        action:     'index',
        report_id:  '1',
        account_id: '1',
        format:     'json'
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
