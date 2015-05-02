require 'test_helper'

class LedgersControllerTest < ActionController::TestCase
  locker_room_fixtures(:accounts, :members, :users)
  fixtures(:accounts, :ledgers)

  def test_get_index
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      ledger = ledgers(:bank)
      get(:index, :account_id => ledger.account_id)
      assert_not_empty(assigns[:ledgers])
      assert_includes(assigns[:ledgers], ledger)
      assert_equal(ledger.account, assigns[:account])
      assert_template(:index)
      assert_response(:success)
    end
  end
end
