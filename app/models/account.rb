class Account < ActiveRecord::Base
  include Sortable

  paginates_per 5
  sortable :name, :description, :started_at,
           :updated_at, :finished_at,
           :created_at, :updated_at

  has_one :budget
  has_one :settlement
  has_many :ledgers

  validates :name,
    presence: true
  validates :name,
    uniqueness: true
  validates :name,
    length: {maximum: 128}

  def save_with_budget_and_settlement
    self.class.transaction do
      result = save
      if result
        create_budget(title: name)
        create_settlement(title: name)
      end
      result
    end
  end
end
