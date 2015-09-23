class Note < ActiveRecord::Base
  include PublicActivity::Model
  include Sortable
  include HtmlConvertable

  acts_as_taggable
  tracked owner:          ->(controller, _) { controller.current_user },
          trackable_name: ->(_, model) { model.title }
  paginates_per 6
  sortable :title, :updated_at
  html_convertable :content

  validates :title,
    presence:   true,
    uniqueness: true,
    length:     {maximum: 192}
  validates :content,
    length: {maximum: 1024 * 4}
end
