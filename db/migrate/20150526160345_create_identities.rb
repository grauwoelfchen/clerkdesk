class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.belongs_to :user,   null: false, index: true
      t.belongs_to :person, null: false, index: true

      t.timestamps null: false
    end
  end
end
