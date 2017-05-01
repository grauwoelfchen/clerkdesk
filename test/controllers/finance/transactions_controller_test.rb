require 'test_helper'

module Finance
  class TransactionsControllerTest < ActionController::TestCase
    locker_room_fixtures(:teams, :users, :mateships)
    fixtures(:'finance/ledgers', :'finance/categories', :'finance/accounts',
      :'finance/journalizings', :'finance/transactions')

    def setup
      @user = locker_room_users(:oswald)
      @team = @user.teams.first

      @ledger  = finance_ledgers(:general_ledger)
      @account = finance_accounts(:general_money)
    end

    # index

    def test_index_assigns_vars
      within_subdomain(@team.subdomain) do
        login_user(@user)
        params = {
          :ledger_id  => @ledger.id,
          :account_id => @account.id
        }
        get(:index, :params => params)
        assert_equal(@ledger, assigns[:ledger])
        assert_equal(@account, assigns[:account])
        assert_equal(@ledger, @account.ledger)
        refute(assigns[:category])
        refute_empty(assigns[:transactions])
      end
    end

    def test_index_raises_notfound_with_unknown_category
      within_subdomain(@team.subdomain) do
        login_user(@user)
        params = {
          :ledger_id  => @ledger.id,
          :account_id => @account.id,
          :c          => 'invalid_id'
        }
        assert_raise(ActiveRecord::RecordNotFound) do
          get(:index, :params => params)
        end
      end
    end

    def test_index_assigns_vars_with_category
      within_subdomain(@team.subdomain) do
        login_user(@user)
        category = finance_categories(:miscellaneous_expense)
        params = {
          :ledger_id  => @ledger.id,
          :account_id => @account.id,
          :c          => category.id
        }
        get(:index, :params => params)
        assert_equal(@ledger, assigns[:ledger])
        assert_equal(@account, assigns[:account])
        assert_equal(@ledger, @account.ledger)
        assert_equal(category, assigns[:category])
        refute_empty(assigns[:transactions])
        assert_equal([category], assigns[:transactions].map(&:category).uniq)
      end
    end

    def test_index_renders_template
      within_subdomain(@team.subdomain) do
        login_user(@user)
        params = {
          :ledger_id  => @ledger.id,
          :account_id => @account.id
        }
        get(:index, :params => params)
        assert_template(:index)
        assert_response(:success)
      end
    end
  end
end
