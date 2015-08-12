module Finance
  class Entry < ActiveRecord::Base
    extend FiscalPolicyExtension
    include Sortable

    self.table_name = 'finance_entries'

    self.inheritance_column = 'null'
    enum_accessor :type, [:expense, :income]

    belongs_to :account_book
    belongs_to :journalizing,
      counter_cache: :entries_count
    has_many :involvements,
      ->{ order(:id => :asc) },
      as: :matter
    has_many :people,
      through:     :involvements,
      source:      :holder,
      source_type: 'Person'
    has_one :category,
      through: :journalizing

    accepts_nested_attributes_for :involvements,
      allow_destroy: true,
      reject_if:     :reject_involvements

    acts_as_taggable
    paginates_per 25
    sortable :title, :type, :journalizing_id, :total_amount, :updated_at

    validates :title,
      presence: true
    validates :title,
      length: {maximum: 128}

    validates :memo,
      length:      {maximum: 1024},
      allow_blank: true

    before_validation :force_sign

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
