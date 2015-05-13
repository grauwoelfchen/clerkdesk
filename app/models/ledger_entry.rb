class LedgerEntry < ActiveRecord::Base
  include Sortable

  self.inheritance_column = "null"
  enum_accessor :type, [:expense, :income]

  belongs_to :ledger
  has_one :journalizing
  has_one :category,
    through: :journalizing,
    class_name: "FinanceCategory"

  acts_as_taggable
  paginates_per 25
  sortable :title, :type, :total_amount, :created_at, :updated_at
end
