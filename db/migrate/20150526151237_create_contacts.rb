class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string  :slug,       null: false
      t.string  :property
      t.string  :name,       null: false, default: ''
      t.string  :postcode
      t.string  :country,    null: false, default: ''
      t.string  :division,   null: false, default: ''
      t.string  :city,       null: false, default: ''
      t.string  :address,    null: false, default: ''
      t.string  :phone
      t.string  :email
      t.string  :memo

      t.timestamps null: false
    end

    add_index :contacts, :slug, unique: true
  end
end
