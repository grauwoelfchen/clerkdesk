require 'test_helper'

class LedgersControllerTest < ActionController::TestCase
  locker_room_fixtures(:accounts, :members, :users)
  fixtures(:finances, :ledgers)

  def test_get_show
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      ledger = ledgers(:general_ledger)
      get(:show, :finance_id => ledger.finance_id)
      assert_equal(ledger, assigns[:ledger])
      assert_equal(ledger.finance, assigns[:finance])
      assert_template(:show)
      assert_response(:success)
    end
  end
end
