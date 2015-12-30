class Contact < ActiveRecord::Base
  include FriendlyId
  include Orderable
  include Searchable

  has_many :involvements,
    ->{ order(:id => :asc) },
    as: :holder
  has_many :finance_entries,
    through:     :involvements,
    source:      :matter,
    source_type: 'Finance::Entry'
  has_one :usership, foreign_key: :user_id
  has_one :user, through: :usership, source: :contact

  acts_as_taggable
  friendly_id :code, use: :slugged
  paginates_per 20
  orderable :name, :updated_at, code: :asc

  validates :code,
    presence: true,
    length:   {maximum: 192}
  validates :code,
    uniqueness:  true,
    format:      {with: /\A[A-z0-9\-_]+\z/},
    allow_blank: true
  validates :name,
    presence: true,
    length:   {maximum: 128}
  validates :country,
    inclusion:   {in: ISO3166::Country.all.map(&:alpha2)},
    allow_blank: true
  validates :city,
    length: {maximum: 64}
  validates :street,
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
    length: {maximum: 1024}

  validate :division_must_be_in_valid_country

  def label
    name + " (#{code})"
  end

  private

  def division_must_be_in_valid_country
    if division.present? && !valid_division?
      errors.add(:division, 'is not included in the list')
    end
  end

  def valid_division?
    return false unless country.present?
    # because this finder does not raise any exception (returns nil)
    country_data = ISO3166::Country.find_country_by_alpha2(country)
    return false unless (country_data && country_data.subdivisions?)
    divisions = country_data.subdivisions
    divisions.keys.include?(division)
  end
end
