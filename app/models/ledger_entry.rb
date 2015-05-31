class LedgerEntry < ActiveRecord::Base
  include Sortable

  self.inheritance_column = "null"
  enum_accessor :type, [:expense, :income]

  belongs_to :ledger
  belongs_to :journalizing,
    counter_cache: :entries_count
  has_one :category,
    through:    :journalizing,
    class_name: "FinanceCategory"

  acts_as_taggable
  paginates_per 25
  sortable :title, :type, :total_amount, :created_at, :updated_at

  validates :title,
    presence: true
  validates :title,
    length: {maximum: 128}

  validates :memo,
    length:      {maximum: 1024},
    allow_blank: true
end
