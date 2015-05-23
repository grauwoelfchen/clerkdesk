require "locker_room/concerns/models/user"

class LockerRoom::User < ActiveRecord::Base
  include LockerRoom::Concerns::Models::User

  validates :locale,
    inclusion: {in: I18n.available_locales.map(&:to_s) }
end
