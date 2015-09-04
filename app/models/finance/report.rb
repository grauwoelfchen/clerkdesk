module Finance
  class Report < ActiveRecord::Base
    extend FiscalPolicyExtension
    include Sortable

    self.table_name = 'finance_reports'

    enum_accessor :state, [:closed, :opened, :primary]
    paginates_per 6
    sortable :name, :description, :state, :updated_at,
             :started_at, :finished_at

    has_one :budget
    has_many :account_books
    has_many :categories
    has_many :journalizings, through: :categories
    has_many :entries, through: :journalizings

    validates :name,
      presence: true
    validates :name,
      uniqueness: true
    validates :name,
      length: {maximum: 128}
    validates :description,
      length: {maximum: 256}
    validate :check_period

    def initialize(attributes=nil, options={})
      today = Time.zone.today
      attributes ||= {}
      defaults = {
        :started_at  => today,
        :finished_at => today + 1.year
      }
      super(attributes.merge(defaults), options)
    end

    def recent_categories(limit_count=5)
      categories
        .includes(:journalizings)
        .order(:updated_at => :desc)
        .limit(limit_count)
    end

    def recent_entries(limit_count=5)
      entries
        .includes(:account_book, :category)
        .order(:updated_at => :desc)
        .limit(limit_count)
    end

    def save_with_fiscal_objects
      transaction do
        result = save
        if result
          create_budget!
          create_initial_account_books!
          create_initial_categories!

          account_books.map do |account_book|
            categories.map do |category|
              category.journalizings.create!(:account_book => account_book)
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

    def create_initial_account_books!
      {
        :cash => 'briefcase', :bank => 'bank'
      }.map do |book_name, icon_name|
        name = I18n.t(book_name, :scope => [:finance, :account_book])
        icons = Rails.application.config.icons
        account_books.create!(:name => name, :icon => icons[icon_name])
      end
    end

    def create_initial_categories!
      %w{
        accumulation carry-over membership-fee correspondence
      }.map do |category|
        name = I18n.t(category, :scope => [:finance, :category])
        categories.create!(:name => name)
      end
    end
  end
end
