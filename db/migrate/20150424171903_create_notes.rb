class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :account_id
      t.string  :title
      t.text    :content

      t.timestamps null: false
    end

    add_index :notes, :account_id
  end
end
