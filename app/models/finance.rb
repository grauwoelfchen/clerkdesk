class Finance < ActiveRecord::Base
  include Sortable

  paginates_per 5
  sortable :name, :description, :started_at,
           :updated_at, :finished_at,
           :created_at, :updated_at

  has_one :budget
  has_one :settlement
  has_one :ledger

  validates :name,
    presence: true
  validates :name,
    uniqueness: true
  validates :name,
    length: {maximum: 128}

  def save_with_ficsal_objects
    self.class.transaction do
      result = save
      if result
        create_budget(title: name)
        create_settlement(title: name)
        create_ledger(title: name)
      end
      result
    end
  end
end
