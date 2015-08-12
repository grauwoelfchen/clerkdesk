require 'test_helper'

class FinanceReportDestroyTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:'finance/reports', :'finance/categories')

  def test_destroy_finance
    user = locker_room_users(:oswald)
    as_logged_in_user(user) do
      report = finance_reports(:general_report)
      visit(finance_reports_url)
      assert_equal(finance_reports_url, page.current_url)
      assert_difference('Finance::Report.count', -1) do
        visit(finance_reports_url)
        href = "/finances/#{report.id}"
        link = find(:xpath, "//a[@href='#{href}' and text()='Delete']")
        # TODO: js driver
        page.driver.submit(:delete, link['href'], {})
      end
    end
  end

  private

  def as_logged_in_user(user)
    within_subdomain(user.team.subdomain) do
      login_user(user)
      yield
      logout_user(locker_room.logout_url, :delete)
    end
  end
end
