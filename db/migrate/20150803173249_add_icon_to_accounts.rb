class AddIconToAccounts < ActiveRecord::Migration
  def change
    add_column :finance_accounts, :icon, :string, limit: 16
  end
end
