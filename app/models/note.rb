class Note < ActiveRecord::Base
  include Sortable
  include HtmlConvertable

  acts_as_taggable
  paginates_per 6
  sortable :title, :updated_at
  html_convertable :content

  validates :title,
    presence:   true,
    uniqueness: true,
    length:     {maximum: 192}
  validates :content,
    length:      {maximum: 1024 * 4},
    allow_blank: true
end
