class Person < ActiveRecord::Base
  include FriendlyId
  include Sortable

  has_one :identity, foreign_key: :user_id
  has_one :user, through: :identity, source: :person

  friendly_id :slug, use: :slugged
  paginates_per 30
  sortable :first_name, :last_name, :slug, :property, :postcode,
    :created_at, :updated_at

  validates :slug,
    presence: true,
    length:   {maximum: 192}
  validates :slug,
    uniqueness:  true,
    format:      {with: /\A[A-z0-9\-_]+\z/},
    allow_blank: true
  validates :property,
    length: {maximum: 192}
  validates :first_name,
    presence: true,
    length:   {maximum: 128}
  validates :last_name,
    presence: true,
    length:   {maximum: 128}
  validates :country,
    inclusion:   {in: Country.all.map { |_, alpha2| alpha2 } },
    allow_blank: true
  validates :city,
    length: {maximum: 64}
  validates :address,
    length: {maximum: 255}
  validates :postcode,
    length:      {maximum: 32},
    format:      {with: /\A[0-9]+\z/},
    allow_blank: true
  validates :phone,
    length:      {maximum: 24},
    format:      {with: /\A[0-9\-\+]+\z/},
    allow_blank: true
  validates :email,
    length:      {maximum: 64},
    format:      {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i},
    allow_blank: true
  validates :memo,
    length: {maximum: 255}
  validates :joined_at,
    date:        true,
    allow_blank: true
  validates :left_at,
    date: {
      after:   :joined_at,
      message: I18n.t(
        "activerecord.errors.attributes.left_at.after_field",
        field: self.human_attribute_name(:joined_at).downcase
      )
    },
    allow_blank: true

  validate :division_must_be_in_valid_country

  def self.full_name_fields
    if I18n.locale == :ja
      "last_name,first_name"
    else
      "first_name,last_name"
    end
  end

  def full_name
    fields = self.class.full_name_fields.split(",")
    fields.map { |field| self.send(field) }.join(" ")
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
