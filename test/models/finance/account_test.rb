require 'test_helper'

module Finance
  class AccountTest < ActiveSupport::TestCase
    locker_room_fixtures(:teams, :users, :mateships)
    fixtures(:'finance/reports', :'finance/accounts')

    def test_validation_with_blank_name
      account = Finance::Account.new(:name => nil)
      refute(account.valid?)
      message = "can't be blank"
      assert_equal([message], account.errors[:name])
    end

    def test_validation_with_duplicated_name_under_same_report
      other_account = finance_accounts(:general_bank)
      report = other_account.report
      account = report.accounts.new(:name => other_account.name)
      refute(account.valid?)
      message = 'has already been taken'
      assert_equal([message], account.errors[:name])
    end

    def test_validation_with_too_long_name
      account = Finance::Account.new(:name => 'long' * 33)
      refute(account.valid?)
      message = 'is too long (maximum is 128 characters)'
      assert_equal([message], account.errors[:name])
    end

    def test_validation_with_blank_icon
      account = Finance::Account.new(:icon => nil)
      refute(account.valid?)
      message = "can't be blank"
      assert_equal([message], account.errors[:icon])
    end

    def test_validation_with_too_long_description
      account = Finance::Account.new(:description => 'long' * 64)
      refute(account.valid?)
      message = 'is too long (maximum is 255 characters)'
      assert_equal([message], account.errors[:description])
    end
  end
end
