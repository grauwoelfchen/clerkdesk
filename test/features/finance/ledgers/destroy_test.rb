require 'test_helper'

class FinanceLedgerDestroyTest < Capybara::Rails::TestCase
  locker_room_fixtures(:teams, :users, :mateships)
  fixtures(:'finance/ledgers', :'finance/categories')

  # FIXME: schema swiching issue
  #   `Apartment::Tenant.current` is already `piano`. But this test fails
  #   without `Apartment::Tenant.switch!`...
  def test_destroy_finance
    behaves_as(:oswald, js: true) do
      Apartment::Tenant.switch!('piano')
      ledger = finance_ledgers(:general_ledger)
      visit(finance_ledgers_url)
      assert_equal(finance_ledgers_url, page.current_url)
      Apartment::Tenant.switch!('piano')
      before_count = Finance::Ledger.count
      #assert_difference('Finance::Ledger.count', -1) do
        visit(finance_ledgers_url)
        href = "/finances/#{ledger.id}"
        link = find(:xpath, "//a[@href='#{href}' and text()='Delete']")
        link.click
      #end
      Apartment::Tenant.switch!('piano')
      after_count = Finance::Ledger.count
      assert_equal(before_count, after_count + 1)
    end
  end
end
