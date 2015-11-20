module Finance
  class Category < ActiveRecord::Base
    extend FiscalPolicyExtension
    include Orderable

    self.table_name = 'finance_categories'
    self.inheritance_column = 'null'

    enum_accessor :type, [:expense, :income]
    paginates_per 16
    orderable :name, :type, :updated_at

    belongs_to :ledger
    has_many :journalizings, dependent: :destroy
    has_many :entries, through: :journalizings

    def self.to_param
      self.class.name
    end

    def save_with_journalizings
      transaction do
        result = save
        if result
          ledger.accounts.map do |account|
            journalizings.create!(:account => account)
          end
        end
        result
      end
    end

    def to_s
      name
    end
  end
end
