module Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, lambda { |query, *fields|
      table     = model_name.plural
      condition = fields.map { |f| "#{table}.#{f} LIKE :q" }.join(' OR ')
      unless condition.empty?
        where(condition, :q => "%#{query}%")
      else
        scoped
      end
    }
  end
end
