class Settlement < ActiveRecord::Base
  belongs_to :finance

  validates :title,
    presence: true
  validates :title,
    uniqueness: true
  validates :title,
    length: {maximum: 128}
end
