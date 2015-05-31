class Journalizing < ActiveRecord::Base
  belongs_to :ledger
  belongs_to :category, class_name: "FinanceCategory"
  has_many :entries,
    dependent:  :nullify,
    class_name: "LedgerEntry"
end
