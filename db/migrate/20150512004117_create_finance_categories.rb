class CreateFinanceCategories < ActiveRecord::Migration
  def change
    create_table :finance_categories do |t|
      t.belongs_to :report, null: false, index: true
      t.integer    :type,   null: false, default: 0
      t.string     :name,   null: false
      t.string     :description

      t.timestamps null: false
    end

    add_index :finance_categories, :type
  end
end
