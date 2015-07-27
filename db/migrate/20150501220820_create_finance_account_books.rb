class CreateFinanceAccountBooks < ActiveRecord::Migration
  def change
    create_table :finance_account_books do |t|
      t.belongs_to :report,      null: false, index: true
      t.string     :name,        null: false
      t.string     :description, null: true
      t.text       :memo

      t.timestamps null: false
    end
  end
end
