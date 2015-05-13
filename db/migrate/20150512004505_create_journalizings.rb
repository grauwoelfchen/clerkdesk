class CreateJournalizings < ActiveRecord::Migration
  def change
    create_table :journalizings do |t|
      t.belongs_to :ledger,         null: false, index: true
      t.belongs_to :category,       null: false, index: true
      t.integer    :entries_count,  null: true, default: 0

      t.timestamps null: false
    end
  end
end
