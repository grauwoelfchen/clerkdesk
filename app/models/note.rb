class Note < ActiveRecord::Base
  acts_as_taggable

  validates :title,
    presence: true
  validates :title,
    uniqueness: true
  validates :title,
    length: {maximum: 192}

  validates :content,
    length: {maximum: 1024 * 4},
    if:     ->(n) { n.content.present? }
end
