require 'test_helper'

class SettlementsControllerTest < ActionController::TestCase
  locker_room_fixtures(:accounts, :members, :users)
  fixtures(:finances, :settlements)

  def test_get_show
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      settlement = settlements(:second_piano_settlement)
      get(:show, :finance_id => settlement.finance_id)
      assert_equal(settlement, assigns[:settlement])
      assert_equal(settlement.finance, assigns[:finance])
      assert_template(:show)
      assert_response(:success)
    end
  end

  def test_get_edit
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      settlement = settlements(:second_piano_settlement)
      get(:edit, :finance_id => settlement.finance_id)
      assert_equal(settlement, assigns[:settlement])
      assert_equal(settlement.finance, assigns[:finance])
      assert_template(:edit)
      assert_template(:partial => "_form")
      assert_response(:success)
    end
  end

  def test_put_update_with_validation_errors
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      settlement = settlements(:second_piano_settlement)
      params = {
        :finance_id => settlement.finance_id,
        :settlement => {
          :title => ""
        }
      }
      put(:update, params)
      assert_equal(settlement, assigns[:settlement])
      assert_equal(settlement.finance, assigns[:finance])
      assert_nil(flash[:notice])
      assert_equal(
        "Settlement could not be updated.",
        ActionController::Base.helpers.strip_tags(flash[:alert])
      )
      assert_template(:edit)
      assert_template(:partial => "shared/_error")
      assert_template(:partial => "_form")
      assert_response(:success)
    end
  end

  def test_put_update
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      settlement = settlements(:second_piano_settlement)
      params = {
        :finance_id => settlement.finance_id,
        :settlement => {
          :title => "Violin settlement"
        }
      }
      put(:update, params)
      assert_equal(params[:settlement][:title], assigns[:settlement].title)
      assert_equal(settlement.finance, assigns[:finance])
      assert_equal(
        "Settlement has been successfully updated.",
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_nil(flash[:error])
      assert_response(:redirect)
      assert_redirected_to(finance_settlement_url(assigns[:finance]))
    end
  end
end
