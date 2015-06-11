require 'test_helper'

class DestroyTest < Capybara::Rails::TestCase
  locker_room_fixtures(:accounts, :members, :users)
  fixtures(:finances, :finance_categories)

  def test_destroy_finance
    user = locker_room_users(:oswald)
    as_logged_in_user(user) do
      finance = finances(:general_finance)
      visit(finances_url)
      assert_equal(finances_url, page.current_url)
      assert_difference("Finance.count", -1) do
        visit(finances_url)
        href = "/finances/#{finance.id}"
        link = find(:xpath, "//a[@href='#{href}' and text()='Delete']")
        # TODO: js driver
        page.driver.submit(:delete, link['href'], {})
      end
    end
  end

  private

  def as_logged_in_user(user)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      yield
      logout_user(locker_room.logout_url, :delete)
    end
  end
end
