class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string   :name
      t.string   :description, null: true,  default: nil
      t.datetime :started_at,  null: true,  default: nil
      t.datetime :finished_at, null: true,  default: nil
      t.integer  :status,      null: false, default: 0

      t.timestamps null: false
    end
  end
end
