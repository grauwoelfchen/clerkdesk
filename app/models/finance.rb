class Finance < ActiveRecord::Base
  include Sortable

  enum_accessor :state, [:closed, :opened, :primary]
  paginates_per 6
  sortable :name, :state, :description, :started_at,
           :updated_at, :finished_at,
           :created_at, :updated_at

  has_one :budget
  has_one :ledger
  has_many :categories, class_name: "FinanceCategory"

  validates :name,
    presence: true
  validates :name,
    uniqueness: true
  validates :name,
    length: {maximum: 128}

  def self.find_or_primary(id)
    if id
      Finance.find(id)
    else
      Finance.where_state(:primary).take!
    end
  end

  def save_with_fiscal_objects
    self.class.transaction do
      result = save
      if result
        create_budget(:title => name)
        ledger = create_ledger(:title => name)
        create_default_categories
        categories.map { |c| c.journalizings.create(:ledger => ledger) }
      end
      result
    end
  end

  private

  def create_default_categories
    %w{accumulation carry-over stationary correspondence membership-fee}.map do |category|
      name = I18n.t(category, :scope => [:finance, :category])
      categories.create(:name => name)
    end
  end
end
