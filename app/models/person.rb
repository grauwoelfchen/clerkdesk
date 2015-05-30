class Person < ActiveRecord::Base
  include FriendlyId

  has_one :identity, foreign_key: :user_id
  has_one :user, through: :identity, source: :person

  friendly_id :slug, use: :slugged

  validates :slug,
    presence: true,
    length:   {maximum: 192}
  with_options if: "slug.present?" do |person|
    person.validates :slug, format: {with: /\A[A-z0-9\-_]+\z/}
    person.validates :slug, uniqueness: true
  end
  validates :property,
    length: {maximum: 192}
  validates :first_name,
    presence: true,
    length:   {maximum: 128}
  validates :last_name,
    presence: true,
    length:   {maximum: 128}
  validates :country,
    inclusion: {in: Country.all.map { |_, alpha2| alpha2 } },
    if:        "country.present?"
  validate :division_must_be_in_valid_country
  validates :postcode,
    length:  {maximum: 32},
    format:  {with: /\A[0-9]+\z/},
    if:      "postcode.present?"

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def division_must_be_in_valid_country
    if division.present? && !valid_division?
      errors.add(:division, "is not included in the list")
    end
  end

  def valid_division?
    return false unless country.present?
    # this finder does not raise any exception (returns nil)
    country_data = Country.find_country_by_alpha2(country)
    return false unless (country_data && country_data.subdivisions?)
    divisions = country_data.subdivisions
    divisions.keys.include?(division)
  end
end
