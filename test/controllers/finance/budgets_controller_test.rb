require "test_helper"

module Finance
  class BudgetsControllerTest < ActionController::TestCase
    locker_room_fixtures(:teams, :users, :mateships)
    fixtures(:'finance/reports', :'finance/budgets')

    def test_get_show
      user = locker_room_users(:oswald)
      within_subdomain(user.team.subdomain) do
        login_user(user)
        budget = finance_budgets(:second_piano_budget)
        get(:show, :report_id => budget.report_id)
        assert_equal(budget, assigns[:budget])
        assert_equal(budget.report, assigns[:report])
        assert_template(:show)
        assert_response(:success)
      end
    end

    def test_get_edit
      user = locker_room_users(:oswald)
      within_subdomain(user.team.subdomain) do
        login_user(user)
        budget = finance_budgets(:second_piano_budget)
        get(:edit, :report_id => budget.report_id)
        assert_equal(budget, assigns[:budget])
        assert_equal(budget.report, assigns[:report])
        assert_template(:edit)
        assert_template(:partial => "_form")
        assert_response(:success)
      end
    end

    def test_put_update_with_validation_errors
      user = locker_room_users(:oswald)
      within_subdomain(user.team.subdomain) do
        login_user(user)
        budget = finance_budgets(:second_piano_budget)
        params = {
          :report_id => budget.report_id,
          :budget  => {
            :description => "Long description" * 100
          }
        }
        put(:update, params)
        budget.reload
        assert_equal(budget, assigns[:budget])
        assert_equal(budget.report, assigns[:report])
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
        budget = finance_budgets(:second_piano_budget)
        params = {
          :report_id => budget.report_id,
          :budget  => {
            :description => "Violin budget"
          }
        }
        put(:update, params)
        budget.reload
        assert_equal(budget, assigns[:budget])
        assert_equal(budget.report, assigns[:report])
        assert_equal(
          "Budget has been successfully updated.",
          ActionController::Base.helpers.strip_tags(flash[:notice])
        )
        assert_nil(flash[:alert])
        assert_response(:redirect)
        assert_redirected_to(finance_report_budget_url(assigns[:report]))
      end
    end
  end
end
