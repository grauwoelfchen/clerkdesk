class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.belongs_to :finance,     null: false, index: true
      t.string     :title,       null: false
      t.text       :description, null: true

      t.timestamps null: false
    end
  end
end
