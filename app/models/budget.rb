class Budget < ActiveRecord::Base
  has_many :ledgers

  validates :title,
    presence: true
  validates :title,
    uniqueness: true
  validates :title,
    length: {maximum: 128}
end
