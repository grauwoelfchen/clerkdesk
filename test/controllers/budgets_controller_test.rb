require "test_helper"

class BudgetsControllerTest < ActionController::TestCase
  locker_room_fixtures(:accounts, :members, :users)
  fixtures(:budgets)

  def test_get_index
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      get(:index)
      refute_empty(assigns[:budgets])
      assert_template(:index)
      assert_response(:success)
    end
  end

  def test_get_show
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      get(:show, :id => budget.id)
      assert_equal(budget, assigns[:budget])
      assert_template(:show)
      assert_response(:success)
    end
  end

  def test_get_new
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      get(:new)
      assert_kind_of(Budget, assigns[:budget])
      assert_template(:new)
      assert_template(:partial => "_form")
      assert_response(:success)
    end
  end

  def test_post_create_with_validation_errors
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      params = {
        :budget  => {
          :title => ""
        }
      }
      assert_no_difference("Budget.count", 1) do
        post(:create, params)
      end
      assert_instance_of(Budget, assigns[:budget])
      refute(assigns[:budget].persisted?)
      assert_nil(flash[:notice])
      assert_template(:new)
      assert_template(:partial => "shared/_error")
      assert_template(:partial => "_form")
      assert_response(:success)
    end
  end

  def test_post_create
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      params = {
        :budget  => {
          :title => "New budget"
        }
      }
      assert_difference("Budget.count", 1) do
        post(:create, params)
      end
      assert_instance_of(Budget, assigns[:budget])
      assert(assigns[:budget].persisted?)
      assert_equal(
        "Budget has been successfully created.",
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_response(:redirect)
      assert_redirected_to(assigns[:budget])
    end
  end

  def test_get_edit
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      get(:edit, :id => budget.id)
      assert_equal(budget, assigns[:budget])
      assert_template(:edit)
      assert_template(:partial => "_form")
      assert_response(:success)
    end
  end

  def test_put_update_with_validation_errors
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      params = {
        :id     => budget.id,
        :budget => {
          :title => ""
        }
      }
      put(:update, params)
      assert_equal(budget, assigns[:budget])
      assert_nil(flash[:notice])
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
      budget = budgets(:second_piano_budget)
      params = {
        :id     => budget.id,
        :budget => {
          :title => "Violin budget"
        }
      }
      put(:update, params)
      assert_equal(params[:budget][:title], assigns[:budget].title)
      assert_equal(
        "Budget has been successfully updated.",
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_response(:redirect)
      assert_redirected_to(assigns[:budget])
    end
  end

  def test_delete_destroy
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      assert_difference("Budget.count", -1) do
        delete(:destroy, :id => budget.id)
      end
      assert_equal(budget, assigns[:budget])
      refute(assigns[:budget].persisted?)
      assert_equal(
        "Budget has been successfully destroyed.",
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_response(:redirect)
      assert_redirected_to(budgets_url)
    end
  end
end
