class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.belongs_to :account, null: false
      t.string     :title
      t.text       :description, null: true

      t.timestamps null: false
    end

    add_index :ledgers, :account_id
  end
end
