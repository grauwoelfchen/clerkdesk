require 'test_helper'

module Finance
  class TransactionTest < ActiveSupport::TestCase
    locker_room_fixtures(:teams, :users, :mateships)
    fixtures(:'finance/transactions',
             :'finance/ledgers', :'finance/categories',
             :'finance/accounts', :'finance/journalizings')

    def test_validation_with_without_title
      txn = Finance::Transaction.new(:title => nil)
      refute(txn.valid?)
      message = 'can\'t be blank'
      assert_equal([message], txn.errors[:title])
    end

    def test_validation_with_too_long_title
      txn = Finance::Transaction.new(:title => 'long' * 33)
      refute(txn.valid?)
      message = 'is too long (maximum is 128 characters)'
      assert_equal([message], txn.errors[:title])
    end

    def test_validation_with_too_long_memo
      txn = Finance::Transaction.new(:memo => 'long' * 257)
      refute(txn.valid?)
      message = 'is too long (maximum is 1024 characters)'
      assert_equal([message], txn.errors[:memo])
    end

    def test_force_sign_callback_with_invalid_sign
      # income with minus value
      txn = Finance::Transaction.new(:type => :income, :total_amount => -1000)
      refute(txn.valid?)
      assert_equal(1000, txn.total_amount)
      # expense with plus value
      txn = Finance::Transaction.new(:type => :expense, :total_amount => 1000)
      refute(txn.valid?)
      assert_equal(-1000, txn.total_amount)
    end
  end
end
