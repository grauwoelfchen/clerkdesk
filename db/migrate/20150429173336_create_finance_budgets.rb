class CreateFinanceBudgets < ActiveRecord::Migration
  def change
    create_table :finance_budgets do |t|
      t.belongs_to :ledger,      null: false, index: true
      t.string     :description, null: true,  default: nil
      t.text       :memo
      t.datetime   :approved_at, null: true,  default: nil

      t.timestamps null: false
    end
  end
end
