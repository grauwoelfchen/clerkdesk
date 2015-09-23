class AddTrackableNameToActivities < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.string :trackable_name
    end
  end
end
