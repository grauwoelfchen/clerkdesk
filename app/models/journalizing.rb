class Journalizing < ActiveRecord::Base
  belongs_to :category, class_name: "FinanceCategory"
  has_many :entries, class_name: "LedgerEntry"
end
