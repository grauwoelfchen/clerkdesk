module Finance
  class Journalizing < ActiveRecord::Base
    extend FiscalPolicyExtension

    self.table_name = "finance_journalizings"

    belongs_to :account_book
    belongs_to :category
    has_many :entries, dependent: :nullify
  end
end
