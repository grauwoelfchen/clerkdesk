require 'locker_room/models/user'

class LockerRoom::User < ActiveRecord::Base
  include LockerRoom::Models::User
  include Orderable

  paginates_per 10
  orderable :username, :updated_at

  has_one :identity, foreign_key: :user_id, class_name: 'Identity'
  has_one :contact, through: :identity, source: :user

  validates :locale,
    inclusion: {in: I18n.available_locales.map(&:to_s)}
end
