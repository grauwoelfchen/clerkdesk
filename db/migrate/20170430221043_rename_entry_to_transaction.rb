class RenameEntryToTransaction < ActiveRecord::Migration[5.1]
  def change
    rename_column :finance_journalizings, :entries_count, :transactions_count
    rename_table :finance_entries, :finance_transactions
  end
end
