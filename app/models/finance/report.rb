module Finance
  class Report < ActiveRecord::Base
    extend FiscalPolicyExtension
    include Sortable

    self.table_name = "finance_reports"

    enum_accessor :state, [:closed, :opened, :primary]
    paginates_per 6
    sortable :name, :description, :state, :started_at,
             :updated_at, :finished_at,
             :created_at, :updated_at

    has_one :budget
    has_many :account_books
    has_many :categories
    has_many :journalizings, through: :categories

    validates :name,
      presence: true
    validates :name,
      uniqueness: true
    validates :name,
      length: {maximum: 128}
    validates :description,
      length: {maximum: 256}
    validate :check_period

    def save_with_fiscal_objects
      self.class.transaction do
        result = save
        if result
          create_budget
          create_initial_account_books
          create_initial_categories

          account_books.map do |b|
            categories.map do |c|
              c.journalizings.create(:account_book => b)
            end
          end
        end
      end
    end

    private

    def check_period
      if started_at >= finished_at
        errors.add(:started_at, :before_than_finished_at)
      end
    end

    def create_initial_account_books
      {cash: 'briefcase', bank: 'bank'}.map do |book, icon|
        name = I18n.t(book, :scope => [:finance, :account_book])
        icons = Rails.application.config.icons
        account_books.create(:name => name, :icon => icons[icon])
      end
    end

    def create_initial_categories
      %w{
        accumulation carry-over membership-fee correspondence
      }.map do |category|
        name = I18n.t(category, :scope => [:finance, :category])
        categories.create(:name => name)
      end
    end
  end
end
