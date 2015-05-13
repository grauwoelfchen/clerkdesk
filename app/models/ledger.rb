class Ledger < ActiveRecord::Base
  belongs_to :finance
  has_many :entries, class_name: "LedgerEntry"

  validates :title,
    presence: true
  validates :title,
    uniqueness: true
  validates :title,
    length: {maximum: 128}

  validates :description,
    length: {maximum: 1024},
    if:     ->(l) { l.description.present? }
end
