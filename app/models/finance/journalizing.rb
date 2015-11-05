module Finance
  class Journalizing < ActiveRecord::Base
    extend FiscalPolicyExtension

    self.table_name = 'finance_journalizings'

    belongs_to :account
    belongs_to :category
    has_many :entries, dependent: :nullify

    scope :category_type, ->(type) {
      includes(:category)
        .joins(:category)
        .where("#{Finance::Category.table_name}.type = ?",
          Finance::Category.types[type])
    }

    def as_json(options)
      {:name => category.name, :id => id}
    end
  end
end
