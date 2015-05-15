require "test_helper"

class LedgerEntryTest < ActiveSupport::TestCase
  locker_room_fixtures(:accounts, :members, :users)
  fixtures(:finances, :finance_categories, :ledgers, :journalizings,
           :ledger_entries)

  def test_validation_with_without_title
    entry = LedgerEntry.new(:title => nil)
    refute(entry.valid?)
    message = "can't be blank"
    assert_equal([message], entry.errors[:title])
  end

  def test_validation_with_too_long_title
    entry = LedgerEntry.new(:title => "long" * 33)
    refute(entry.valid?)
    message = "is too long (maximum is 128 characters)"
    assert_equal([message], entry.errors[:title])
  end

  def test_validation_with_too_long_memo
    entry = LedgerEntry.new(:memo => "long" * 257)
    refute(entry.valid?)
    message = "is too long (maximum is 1024 characters)"
    assert_equal([message], entry.errors[:memo])
  end
end
