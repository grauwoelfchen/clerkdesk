module Finance
  class Budget < ActiveRecord::Base
    extend FiscalPolicyExtension

    self.table_name = "finance_budgets"

    belongs_to :report

    validates :description,
      length: {maximum: 256}
    validates :memo,
      length: {maximum: 1024}
  end
end
