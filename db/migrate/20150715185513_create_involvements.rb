class CreateInvolvements < ActiveRecord::Migration
  def change
    create_table :involvements do |t|
      t.string  :holder_type
      t.integer :holder_id
      t.string  :matter_type
      t.integer :matter_id

      t.timestamps null: false
    end

    add_index :involvements, [:holder_type, :holder_id]
    add_index :involvements, [:matter_type, :matter_id]
  end
end
