require 'test_helper'

module Finance
  class AccountsControllerTest < ActionController::TestCase
    locker_room_fixtures(:teams, :users, :mateships)
    fixtures(:'finance/ledgers', :'finance/accounts')

    def test_get_show
      user = locker_room_users(:oswald)
      team = user.teams.first
      within_subdomain(team.subdomain) do
        login_user(user)
        account = finance_accounts(:general_money)
        get(:show, :ledger_id => account.ledger_id, :id => account.id)
        assert_equal(account, assigns[:account])
        assert_equal(account.ledger, assigns[:ledger])
        assert_template(:show)
        assert_response(:success)
      end
    end
  end
end
