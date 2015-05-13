class CreateLedgerEntries < ActiveRecord::Migration
  def change
    create_table :ledger_entries do |t|
      t.belongs_to :ledger,       null: false, index: true
      t.belongs_to :journalizing, null: true,  index: true
      t.integer    :type,         null: false, default: 0
      t.string     :title,        null: false
      t.integer    :total_amount, null: false, default: 0
      t.string     :memo,         null: true

      t.timestamps null: false
    end

    add_index :ledger_entries, :type
  end
end
