class CreateUserships < ActiveRecord::Migration
  def change
    create_table :userships do |t|
      t.belongs_to :user,    null: false, index: true
      t.belongs_to :contact, null: false, index: true

      t.timestamps null: false
    end
  end
end
