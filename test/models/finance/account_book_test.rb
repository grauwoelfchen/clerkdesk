require "test_helper"

module Finance
  class AccountBookTest < ActiveSupport::TestCase
    locker_room_fixtures(:teams, :users, :memberships)
    fixtures(:'finance/reports', :'finance/account_books')

    def test_validation_with_blank_name
      account_book = Finance::AccountBook.new(:name => nil)
      refute(account_book.valid?)
      message = "can't be blank"
      assert_equal([message], account_book.errors[:name])
    end

    def test_validation_with_duplicated_name_under_same_report
      other_account_book = finance_account_books(:general_bank)
      report = other_account_book.report
      account_book = report.account_books.new(:name => other_account_book.name)
      refute(account_book.valid?)
      message = "has already been taken"
      assert_equal([message], account_book.errors[:name])
    end

    def test_validation_with_too_long_name
      account_book = Finance::AccountBook.new(:name => "long" * 33)
      refute(account_book.valid?)
      message = "is too long (maximum is 128 characters)"
      assert_equal([message], account_book.errors[:name])
    end

    def test_validation_with_blank_icon
      account_book = Finance::AccountBook.new(:icon => nil)
      refute(account_book.valid?)
      message = "can't be blank"
      assert_equal([message], account_book.errors[:icon])
    end

    def test_validation_with_too_long_description
      account_book = Finance::AccountBook.new(:description => "long" * 64)
      refute(account_book.valid?)
      message = "is too long (maximum is 255 characters)"
      assert_equal([message], account_book.errors[:description])
    end
  end
end
