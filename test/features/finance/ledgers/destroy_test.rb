require 'test_helper'

class FinanceLedgerDestroyTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:'finance/ledgers', :'finance/categories')

  def test_destroy_finance
    within_js_driver do
      user = locker_room_users(:oswald)
      team = user.teams.first
      within_subdomain(team.subdomain) do
        signin_user(user)
        ledger = finance_ledgers(:general_ledger)
        visit(finance_ledgers_url)
        assert_equal(finance_ledgers_url, page.current_url)
        assert_difference('Finance::Ledger.count', -1) do
          visit(finance_ledgers_url)
          href = "/finances/#{ledger.id}"
          link = find(:xpath, "//a[@href='#{href}' and text()='Delete']")
          link.click
        end
        signout_user
      end
    end
  end
end
