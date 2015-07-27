module Finance
  class AccountBook < ActiveRecord::Base
    extend FiscalPolicyExtension

    self.table_name = "finance_account_books"

    belongs_to :report
    has_many :journalizings
    has_many :categories, through: :journalizings
    has_many :entries

    validates :name,
      presence: true
    validates :name,
      uniqueness: true
    validates :name,
      length: {maximum: 128}

    validates :description,
      length:      {maximum: 256},
      allow_blank: true
  end
end
