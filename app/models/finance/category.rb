module Finance
  class Category < ActiveRecord::Base
    extend FiscalPolicyExtension
    include Sortable

    self.table_name = "finance_categories"
    self.inheritance_column = "null"

    enum_accessor :type, [:expense, :income]
    paginates_per 16
    sortable :name, :type, :created_at, :updated_at

    belongs_to :report
    has_many :journalizings, dependent: :destroy
    has_many :entries, through: :journalizings

    def self.to_param
      self.class.name
    end

    def to_s
      name
    end
  end
end
