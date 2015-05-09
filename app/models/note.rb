class Note < ActiveRecord::Base
  include Sortable
  include HtmlConvertable

  paginates_per 12
  acts_as_taggable
  sortable :title, :content, :created_at, :updated_at
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
