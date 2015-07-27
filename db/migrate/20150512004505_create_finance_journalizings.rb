class CreateFinanceJournalizings < ActiveRecord::Migration
  def change
    create_table :finance_journalizings do |t|
      t.belongs_to :account_book,  null: false, index: true
      t.belongs_to :category,      null: false, index: true
      t.integer    :entries_count, null: true, default: 0

      t.timestamps null: false
    end
  end
end
