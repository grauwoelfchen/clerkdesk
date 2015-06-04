class FinanceCategory < ActiveRecord::Base
  include Sortable

  self.inheritance_column = "null"
  enum_accessor :type, [:expense, :income]
  paginates_per 16
  sortable :name, :type, :created_at, :updated_at

  belongs_to :finance
  has_many :journalizings,
    foreign_key: :category_id,
    dependent:   :destroy
  has_many :entries,
    through:    :journalizings,
    class_name: "LedgerEntries"

  def to_s
    name
  end
end
