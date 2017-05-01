require 'test_helper'

module Finance
  class AccountsControllerTest < ActionController::TestCase
    locker_room_fixtures(:teams, :users, :mateships)
    fixtures(:'finance/ledgers', :'finance/categories', :'finance/accounts')

    def setup
      @user = locker_room_users(:oswald)
      @team = @user.teams.first

      @ledger = finance_ledgers(:general_ledger)
    end

    # index

    def test_index_should_assign_vars
      within_subdomain(@team.subdomain) do
        login_user(@user)
        get(:index, :params => {:ledger_id => @ledger.id})
        assert_equal(@ledger, assigns[:ledger])
        accounts = @ledger.accounts.order_by(:name, :asc)
        assert_equal(accounts, assigns[:accounts])
        refute_empty(assigns[:accounts])
      end
    end

    def test_index_should_render_template
      within_subdomain(@team.subdomain) do
        login_user(@user)
        get(:index, :params => {:ledger_id => @ledger.id})
        assert_template(:index)
        assert_response(:success)
      end
    end

    # new

    def test_new_should_redirect_with_accounts_count_limit_over
      within_subdomain(@team.subdomain) do
        login_user(@user)
        # >= 20
        (20 - @ledger.accounts.length).times do |i|
          @ledger.accounts.create!(name: "Account #{i}", icon: 'archive')
        end
        get(:new, :params => {:ledger_id => @ledger.id})
        assert_response(:redirect)
        expected = {
          :controller => 'finance/accounts',
          :action     => 'index',
          :ledger_id  => @ledger.id
        }
        assert_equal(
          'You cannot create over 20 accounts.',
          ActionController::Base.helpers.strip_tags(flash[:alert])
        )
        assert_redirected_to(expected)
      end
    end

    def test_new_should_assign_vars
      within_subdomain(@team.subdomain) do
        login_user(@user)
        get(:new, :params => {:ledger_id => @ledger.id})
        assert_equal(@ledger, assigns[:ledger])
        assert_instance_of(Finance::Account, assigns[:account])
        refute(assigns[:account].persisted?)
      end
    end

    def test_new_should_render_template
      within_subdomain(@team.subdomain) do
        login_user(@user)
        get(:new, :params => {:ledger_id => @ledger.id})
        assert_template(:new)
        assert_template(:partial => '_form')
        assert_response(:success)
      end
    end

    # create

    def test_create_should_not_store_new_account_with_validation_error
      within_subdomain(@team.subdomain) do
        login_user(@user)
        params = {
          :ledger_id => @ledger.id,
          :account   => {
            :name => '',
            :icon => 'bank'
          }
        }
        post(:create, :params => params)
        assert_equal(@ledger, assigns[:ledger])
        assert_instance_of(Finance::Account, assigns[:account])
        refute_empty(assigns[:account].errors)
        assert_includes(assigns[:account].changed, 'name')
        refute(assigns[:account].persisted?)
      end
    end

    def test_create_should_render_form_again_with_validation_error
      within_subdomain(@team.subdomain) do
        login_user(@user)
        params = {
          :ledger_id => @ledger.id,
          :account   => {
            :name => '',
            :icon => 'bank'
          }
        }
        post(:create, :params => params)
        assert_template(:new)
        assert_template(:partial => 'shared/_error')
        assert_template(:partial => '_form')
        assert_response(:success)
      end
    end

    def test_create_should_set_alert_message_with_validation_error
      within_subdomain(@team.subdomain) do
        login_user(@user)
        params = {
          :ledger_id => @ledger.id,
          :account   => {
            :name => '',
            :icon => 'bank'
          }
        }
        post(:create, :params => params)
        assert_nil(flash[:notice])
        assert_equal(
          'Account could not be created.',
          ActionController::Base.helpers.strip_tags(flash[:alert])
        )
      end
    end

    def test_create_should_redirect_with_accounts_count_limit_over
      within_subdomain(@team.subdomain) do
        login_user(@user)
        # >= 20
        (20 - @ledger.accounts.length).times do |i|
          @ledger.accounts.create!(name: "Account #{i}", icon: 'archive')
        end
        params = {
          :ledger_id => @ledger.id,
          :account => {
            :name => 'Coffee Card',
            :icon => 'bank'
          }
        }
        post(:create, :params => params)
        assert_response(:redirect)
        expected = {
          :controller => 'finance/accounts',
          :action     => 'index',
          :ledger_id  => @ledger.id
        }
        assert_equal(
          'You cannot create over 20 accounts.',
          ActionController::Base.helpers.strip_tags(flash[:alert])
        )
        assert_redirected_to(expected)
      end
    end

    def test_create_should_store_new_account
      within_subdomain(@team.subdomain) do
        login_user(@user)
        params = {
          :ledger_id => @ledger.id,
          :account => {
            :name => 'Coffee Card',
            :icon => 'bank'
          }
        }
        post(:create, :params => params)
        assert_equal(@ledger, assigns[:ledger])
        assert_includes(@ledger.accounts, assigns[:account])
        assert(assigns[:account].persisted?)
        refute_empty(assigns[:account].categories)
      end
    end

    def test_create_should_redirect_to_account_transactions_after_store
      within_subdomain(@team.subdomain) do
        login_user(@user)
        params = {
          :ledger_id => @ledger.id,
          :account   => {
            :name => 'Coffee Card',
            :icon => 'bank'
          }
        }
        post(:create, :params => params)
        assert_response(:redirect)
        expected = {
          :controller => 'finance/transactions',
          :action     => 'index',
          :ledger_id  => @ledger.id,
          :account_id => assigns[:account].id
        }
        assert_redirected_to(expected)
      end
    end

    def test_create_should_set_notice_message
      within_subdomain(@team.subdomain) do
        login_user(@user)
        params = {
          :ledger_id => @ledger.id,
          :account => {
            :name => 'Coffee Card',
            :icon => 'bank'
          }
        }
        post(:create, :params => params)
        assert_nil(flash[:alert])
        assert_equal(
          'Account has been successfully created.',
          ActionController::Base.helpers.strip_tags(flash[:notice])
        )
      end
    end

    # edit

    def test_edit_should_assign_vars
      within_subdomain(@team.subdomain) do
        login_user(@user)
        account = finance_accounts(:general_bank)
        params = {
          :ledger_id => @ledger.id,
          :id        => account.id
        }
        get(:edit, :params => params)
        assert_equal(@ledger, assigns[:ledger])
        assert_equal(account, assigns[:account])
      end
    end

    def test_edit_should_render_template
      within_subdomain(@team.subdomain) do
        login_user(@user)
        account = finance_accounts(:general_bank)
        params = {
          :ledger_id => @ledger.id,
          :id        => account.id
        }
        get(:edit, :params => params)
        assert_template(:edit)
        assert_template(:partial => '_form')
        assert_response(:success)
      end
    end

    # update

    def test_update_should_not_modify_account_with_validation_error
      within_subdomain(@team.subdomain) do
        login_user(@user)
        account = finance_accounts(:general_bank)
        params = {
          :ledger_id => @ledger.id,
          :id        => account.id,
          :account => {
            :name => ''
          }
        }
        put(:update, :params => params)
        assert_equal(@ledger, assigns[:ledger])
        account.reload
        assert_equal(account, assigns[:account])
        refute_empty(assigns[:account].errors)
        assert_includes(assigns[:account].changed, 'name')
      end
    end

    def test_update_should_render_form_again_with_validation_error
      within_subdomain(@team.subdomain) do
        login_user(@user)
        account = finance_accounts(:general_bank)
        params = {
          :ledger_id => @ledger.id,
          :id        => account.id,
          :account => {
            :name => ''
          }
        }
        put(:update, :params => params)
        assert_template(:edit)
        assert_template(:partial => 'shared/_error')
        assert_template(:partial => '_form')
        assert_response(:success)
      end
    end

    def test_update_should_set_alert_message_with_validation_error
      within_subdomain(@team.subdomain) do
        login_user(@user)
        account = finance_accounts(:general_bank)
        params = {
          :ledger_id => @ledger.id,
          :id        => account.id,
          :account => {
            :name => '',
            :icon => 'bank'
          }
        }
        put(:update, :params => params)
        assert_nil(flash[:notice])
        assert_equal(
          'Account could not be updated.',
          ActionController::Base.helpers.strip_tags(flash[:alert])
        )
      end
    end

    def test_update_should_modify_account
      within_subdomain(@team.subdomain) do
        login_user(@user)
        account = finance_accounts(:general_bank)
        params = {
          :ledger_id => @ledger.id,
          :id        => account.id,
          :account => {
            :name => 'New Bank'
          }
        }
        put(:update, :params => params)
        assert_equal(@ledger, assigns[:ledger])
        assert_not_equal(account.name, assigns[:account].name)
        assert_empty(assigns[:account].errors)
      end
    end

    def test_update_should_redirect_to_finance_transactions_after_modify
      within_subdomain(@team.subdomain) do
        login_user(@user)
        account = finance_accounts(:general_bank)
        params = {
          :ledger_id => @ledger.id,
          :id        => account.id,
          :account => {
            :name => 'New Bank'
          }
        }
        put(:update, :params => params)
        assert_response(:redirect)
        expected = {
          :controller => 'finance/transactions',
          :action     => 'index',
          :ledger_id  => @ledger.id,
          :account_id => assigns[:account].id
        }
        assert_redirected_to(expected)
      end
    end

    def test_update_should_set_notice_message
      within_subdomain(@team.subdomain) do
        login_user(@user)
        account = finance_accounts(:general_bank)
        params = {
          :ledger_id => @ledger.id,
          :id        => account.id,
          :account => {
            :name => 'New Bank',
          }
        }
        put(:update, :params => params)
        assert_nil(flash[:alert])
        assert_equal(
          'Account has been successfully updated.',
          ActionController::Base.helpers.strip_tags(flash[:notice])
        )
      end
    end
  end
end
