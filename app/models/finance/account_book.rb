module Finance
  class AccountBook < ActiveRecord::Base
    extend FiscalPolicyExtension

    self.table_name = "finance_account_books"

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
  end
end
