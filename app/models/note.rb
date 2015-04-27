class Note < ActiveRecord::Base
  extend LockerRoom::ScopedTo
  acts_as_taggable
end
