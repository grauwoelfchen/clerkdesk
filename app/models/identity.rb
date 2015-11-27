class Usership < ActiveRecord::Base
  belongs_to :user, class_name: 'LockerRoom::User'
  belongs_to :contact
end
