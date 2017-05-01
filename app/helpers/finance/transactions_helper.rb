module Finance
  module TransactionsHelper
    def account_transaction_contact_labels(transaction)
      if transaction.persisted?
        transaction.contacts.map(&:label)
      else
        transaction.involvements.inject([]) { |acc, involvement|
          acc << involvement.holder if involvement.holder_type == 'Contact'
        }.map(&:label)
      end
    end
  end
end
