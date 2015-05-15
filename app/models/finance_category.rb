class FinanceCategory < ActiveRecord::Base
  self.inheritance_column = "null"
  enum_accessor :type, [:expense, :income]

  belongs_to :finance
  has_many :journalizings
  has_many :entries,
    through: :journalizings,
    class_name: "LedgerEntries"
end
