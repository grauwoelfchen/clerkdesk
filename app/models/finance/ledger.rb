module Finance
  class Ledger < ActiveRecord::Base
    extend FiscalPolicyExtension
    include Orderable

    self.table_name = 'finance_ledgers'

    enum_accessor :state, [:closed, :opened, :primary]
    paginates_per 6
    orderable :name, :description, :state, :updated_at,
              :started_at, :finished_at

    has_one :budget
    has_many :accounts
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

    def initialize(attributes={})
      today = Time.zone.today
      attributes ||= {}
      defaults = {
        :started_at  => today,
        :finished_at => today + 1.year
      }
      super(attributes.merge(defaults))
    end

    def recent_categories(limit_count=5)
      categories
        .includes(:journalizings)
        .order(:updated_at => :desc)
        .limit(limit_count)
    end

    def recent_entries(limit_count=5)
      entries
        .includes(:account, :category)
        .order(:updated_at => :desc)
        .limit(limit_count)
    end

    def save_with_fiscal_objects
      transaction do
        result = save
        if result
          create_budget!
          create_initial_accounts!
          create_initial_categories!

          accounts.map do |account|
            categories.map do |category|
              category.journalizings.create!(:account => account)
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

    def create_initial_accounts!
      {
        :cash => 'briefcase', :bank => 'bank'
      }.map do |account_name, icon|
        name = I18n.t(account_name, :scope => [:finance, :account])
        accounts.create!(:name => name, :icon => icon)
      end
    end

    def create_initial_categories!
      {
        :accumulation     => :income,
        :'carry-over'     => :income,
        :'membership-fee' => :income,
        :correspondence   => :expense,
        :stationery       => :expense
      }.map do |category, type|
        name = I18n.t(category, :scope => [:finance, :category])
        categories.create!(:name => name, :type => type)
      end
    end
  end
end
