require 'test_helper'

module Finance
  class EntryTest < ActiveSupport::TestCase
    locker_room_fixtures(:teams, :users, :mateships)
    fixtures(:'finance/entries',
             :'finance/reports', :'finance/categories',
             :'finance/account_books', :'finance/journalizings')

    def test_validation_with_without_title
      entry = Finance::Entry.new(:title => nil)
      refute(entry.valid?)
      message = "can't be blank"
      assert_equal([message], entry.errors[:title])
    end

    def test_validation_with_too_long_title
      entry = Finance::Entry.new(:title => 'long' * 33)
      refute(entry.valid?)
      message = 'is too long (maximum is 128 characters)'
      assert_equal([message], entry.errors[:title])
    end

    def test_validation_with_too_long_memo
      entry = Finance::Entry.new(:memo => 'long' * 257)
      refute(entry.valid?)
      message = 'is too long (maximum is 1024 characters)'
      assert_equal([message], entry.errors[:memo])
    end

    def test_force_sign_callback_with_invalid_sign
      # income with minus value
      entry = Finance::Entry.new(:type => :income, :total_amount => -1000)
      refute(entry.valid?)
      assert_equal(1000, entry.total_amount)
      # expense with plus value
      entry = Finance::Entry.new(:type => :expense, :total_amount => 1000)
      refute(entry.valid?)
      assert_equal(-1000, entry.total_amount)
    end
  end
end
