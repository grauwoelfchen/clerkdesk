class CreateFinanceLedgers < ActiveRecord::Migration
  def change
    create_table :finance_ledgers do |t|
      t.string   :name
      t.string   :description, null: true,  default: nil
      t.date     :started_at,  null: true,  default: nil
      t.date     :finished_at, null: true,  default: nil
      t.integer  :state,       null: false, default: 0

      t.timestamps null: false
    end

    add_index :finance_ledgers, :state
  end
end
