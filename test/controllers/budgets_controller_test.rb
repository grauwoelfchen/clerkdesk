require "test_helper"

class BudgetsControllerTest < ActionController::TestCase
  locker_room_fixtures(:teams, :users, :memberships)
  fixtures(:finances, :budgets)

  def test_get_show
    user = locker_room_users(:oswald)
    within_subdomain(user.team.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      get(:show, :finance_id => budget.finance_id)
      assert_equal(budget, assigns[:budget])
      assert_equal(budget.finance, assigns[:finance])
      assert_template(:show)
      assert_response(:success)
    end
  end

  def test_get_edit
    user = locker_room_users(:oswald)
    within_subdomain(user.team.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      get(:edit, :finance_id => budget.finance_id)
      assert_equal(budget, assigns[:budget])
      assert_equal(budget.finance, assigns[:finance])
      assert_template(:edit)
      assert_template(:partial => "_form")
      assert_response(:success)
    end
  end

  def test_put_update_with_validation_errors
    user = locker_room_users(:oswald)
    within_subdomain(user.team.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      params = {
        :finance_id => budget.finance_id,
        :budget     => {
          :title => ""
        }
      }
      put(:update, params)
      assert_equal(budget, assigns[:budget])
      assert_equal(budget.finance, assigns[:finance])
      assert_nil(flash[:notice])
      assert_equal(
        "Budget could not be updated.",
        ActionController::Base.helpers.strip_tags(flash[:alert])
      )
      assert_template(:edit)
      assert_template(:partial => "shared/_error")
      assert_template(:partial => "_form")
      assert_response(:success)
    end
  end

  def test_put_update
    user = locker_room_users(:oswald)
    within_subdomain(user.team.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      params = {
        :finance_id => budget.finance_id,
        :budget     => {
          :title => "Violin budget"
        }
      }
      put(:update, params)
      assert_equal(params[:budget][:title], assigns[:budget].title)
      assert_equal(budget.finance, assigns[:finance])
      assert_equal(
        "Budget has been successfully updated.",
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_nil(flash[:alert])
      assert_response(:redirect)
      assert_redirected_to(finance_budget_url(assigns[:finance]))
    end
  end
end
