class FinanceCategory < ActiveRecord::Base
  self.inheritance_column = "null"
  enum_accessor :type, [:expense, :income]

  belongs_to :finance
  has_many :journalizings,
    foreign_key: :category_id,
    dependent:   :destroy
  has_many :entries,
    through: :journalizings,
    class_name: "LedgerEntries"

  def to_s
    name
  end
end
