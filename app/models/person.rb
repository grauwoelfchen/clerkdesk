class Person < ActiveRecord::Base
  include FriendlyId

  has_one :identity, foreign_key: :user_id
  has_one :user, through: :identity, source: :person

  friendly_id :slug, use: :slugged

  validates :first_name,
    presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
