class CreateSettlements < ActiveRecord::Migration
  def change
    create_table :settlements do |t|
      t.belongs_to :finance,     null: false, index: true
      t.string     :title,       null: false
      t.text       :description, null: true,  default: nil
      t.integer    :carryover,   null: false, default: 0
      t.datetime   :approved_at, null: true,  default: nil

      t.timestamps null: false
    end
  end
end
