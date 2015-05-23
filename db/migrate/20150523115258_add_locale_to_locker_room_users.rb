class AddLocaleToLockerRoomUsers < ActiveRecord::Migration
  def change
    add_column :locker_room_users, :locale, :string, limit: 5, null: false, default: 'en'
  end
end
