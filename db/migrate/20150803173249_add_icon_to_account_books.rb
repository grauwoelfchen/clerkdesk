class AddIconToAccountBooks < ActiveRecord::Migration
  def change
    add_column :finance_account_books, :icon, :string, limit: 8
  end
end
