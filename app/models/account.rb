class Account < ActiveRecord::Base
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
