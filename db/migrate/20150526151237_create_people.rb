class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string  :slug,        null: false
      t.string  :property,    null: true
      t.string  :first_name,  null: false, default: ""
      t.string  :last_name,   null: false, default: ""
      t.string  :zip_code,    null: true
      t.string  :country,     null: false, default: ""
      t.string  :state,       null: false, default: ""
      t.string  :city,        null: false, default: ""
      t.string  :address,     null: false, default: ""
      t.string  :phone,       null: true
      t.string  :email,       null: true
      t.string  :memo,        null: true
      t.datetime :joined_at, null: true, default: nil
      t.datetime :left_at,   null: true, default: nil

      t.timestamps null: false
    end

    add_index :people, :slug, unique: true
  end
end
