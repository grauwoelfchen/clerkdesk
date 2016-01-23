require 'test_helper'

class FinanceLedgerDestroyTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:'finance/ledgers', :'finance/categories')

  def test_destroy_finance
    behaves_as(:oswald, js: true) do
      ledger = finance_ledgers(:general_ledger)
      visit(finance_ledgers_url)
      assert_equal(finance_ledgers_url, page.current_url)
      assert_difference('Finance::Ledger.count', -1) do
        visit(finance_ledgers_url)
        href = "/finances/#{ledger.id}"
        link = find(:xpath, "//a[@href='#{href}' and text()='Delete']")
        link.click
      end
    end
  end
end
