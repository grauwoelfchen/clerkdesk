class Finance < ActiveRecord::Base
  include Sortable

  paginates_per 6
  sortable :name, :description, :started_at,
           :updated_at, :finished_at,
           :created_at, :updated_at

  has_one :budget
  has_one :settlement
  has_one :ledger
  has_many :categories, class_name: "FinanceCategory"

  validates :name,
    presence: true
  validates :name,
    uniqueness: true
  validates :name,
    length: {maximum: 128}

  def save_with_fiscal_objects
    self.class.transaction do
      result = save
      if result
        create_budget(:title => name)
        create_settlement(:title => name)
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
