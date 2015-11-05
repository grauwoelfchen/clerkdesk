require 'test_helper'

class FinanceReportDestroyTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:'finance/reports', :'finance/categories')

  def test_destroy_finance
    within_js_driver do
      user = locker_room_users(:oswald)
      team = user.teams.first
      within_subdomain(team.subdomain) do
        signin_user(user)
        report = finance_reports(:general_report)
        visit(finance_reports_url)
        assert_equal(finance_reports_url, page.current_url)
        assert_difference('Finance::Report.count', -1) do
          visit(finance_reports_url)
          href = "/finances/#{report.id}"
          link = find(:xpath, "//a[@href='#{href}' and text()='Delete']")
          link.click
        end
        signout_user
      end
    end
  end
end
