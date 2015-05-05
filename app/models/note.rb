class Note < ActiveRecord::Base
  include HtmlConvertable

  acts_as_taggable
  html_convertable :content

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
