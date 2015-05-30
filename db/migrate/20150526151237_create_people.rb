class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string  :slug,       null: false
      t.string  :property
      t.string  :first_name, null: false, default: ""
      t.string  :last_name,  null: false, default: ""
      t.string  :postcode
      t.string  :country,    null: false, default: ""
      t.string  :division,   null: false, default: ""
      t.string  :city,       null: false, default: ""
      t.string  :address,    null: false, default: ""
      t.string  :phone
      t.string  :email
      t.string  :memo
      t.datetime :joined_at, null: true, default: nil
      t.datetime :left_at,   null: true, default: nil

      t.timestamps null: false
    end

    add_index :people, :slug, unique: true
  end
end
