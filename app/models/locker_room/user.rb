require "locker_room/concerns/models/user"

class LockerRoom::User < ActiveRecord::Base
  include LockerRoom::Concerns::Models::User
  include Sortable

  paginates_per 10
  sortable :username, :created_at, :updated_at

  has_one :identity, foreign_key: :user_id, class_name: "Identity"
  has_one :person, through: :identity, source: :user

  validates :locale,
    inclusion: {in: I18n.available_locales.map(&:to_s) }
end
