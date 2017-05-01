module Finance
  class Transaction < ActiveRecord::Base
    extend FiscalPolicyExtension
    include Orderable

    self.table_name = 'finance_transactions'

    self.inheritance_column = 'null'
    enum_accessor :type, [:expense, :income]

    belongs_to :account
    belongs_to :journalizing,
      counter_cache: :transactions_count
    has_many :involvements,
      ->{ order(:id => :asc) },
      as: :matter
    has_many :contacts,
      through:     :involvements,
      source:      :holder,
      source_type: 'Contact'
    has_one :category,
      through: :journalizing

    accepts_nested_attributes_for :involvements,
      allow_destroy: true,
      reject_if:     :reject_involvements

    acts_as_taggable
    paginates_per 25
    orderable :title, :type, :journalizing_id, :total_amount, :updated_at

    validates :title,
      presence: true
    validates :title,
      length: {maximum: 128}

    validates :memo,
      length:      {maximum: 1024},
      allow_blank: true

    before_validation :force_sign

    def self.total_expense
      where_type(:expense).sum(:total_amount)
    end

    def self.total_income
      where_type(:income).sum(:total_amount)
    end

    private

    def reject_involvements(attributes)
      attributes[:_destroy] == '0'
    end

    def force_sign
      if (type_income?  && total_amount < 0) ||
         (type_expense? && total_amount > 0)
        self.total_amount *= -1
      end
    end
  end
end
