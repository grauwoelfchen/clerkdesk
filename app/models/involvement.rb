class Involvement < ActiveRecord::Base
  belongs_to :holder, polymorphic: true
  belongs_to :matter, polymorphic: true
end
