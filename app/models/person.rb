class Person < ActiveRecord::Base
  include FriendlyId

  has_one :identity, foreign_key: :user_id
  has_one :user, through: :identity, source: :person

  friendly_id :slug, use: :slugged

  validates :slug,
    uniqueness: true,
    length:     {maximum: 192},
    format:     {with: /\A[A-z0-9\-_]+\z/}
  validates :property,
    length: {maximum: 192}
  validates :first_name,
    presence: true,
    length:   {maximum: 128}
  validates :last_name,
    presence: true,
    length:   {maximum: 128}
  validates :country,
    inclusion: {in: Country.all.map { |_, alpha2| alpha2 } }

  validate :state_must_be_in_valid_country

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def state_must_be_in_valid_country
    if state.present? && !valid_state?
      errors.add(:state, "is not included in the list")
    end
  end

  def valid_state?
    return false unless country.present?
    # this finder does not raise any exception (returns nil)
    country_data = Country.find_country_by_alpha2(country)
    return false unless (country_data && country_data.subdivisions?)
    subdivisions = country_data.subdivisions
    subdivisions.keys.include?(state)
  end
end
