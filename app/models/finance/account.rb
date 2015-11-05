module Finance
  class Account < ActiveRecord::Base
    extend FiscalPolicyExtension

    self.table_name = 'finance_accounts'

    belongs_to :report
    has_many :journalizings
    has_many :categories, through: :journalizings
    has_many :entries

    validates :name,
      presence:   true,
      uniqueness: {scope: :report_id},
      length:     {maximum: 128}
    validates :icon,
      presence:   true
    validates :icon,
      inclusion:   {in: Rails.application.config.icons.values},
      allow_blank: true
    validates :description,
      length:      {maximum: 255},
      allow_blank: true

    def save_with_category
      transaction do
        result = save
        if result
          report.categories.map do |category|
            journalizings.create!(:category => category)
          end
        end
        result
      end
    end
  end
end
