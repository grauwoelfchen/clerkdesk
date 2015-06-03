module Sortable
  extend ActiveSupport::Concern

  class_methods do
    def sortable(*attributes)
      @sortable_attributes = attributes.map(&:to_s)
    end

    def sortable_attributes
      @sortable_attributes || []
    end
  end

  included do
    scope :sort, ->(field = nil, direction = nil) {
      fields = field.to_s.split(',')
      option = fields.inject({}) do |opt, fld|
                 if fld.in?(self.sortable_attributes)
                   opt[fld] = (direction == "desc") ? :desc : :asc
                 end
                 opt
               end
      option[:updated_at] = :desc if option.empty?
      order(option)
    }
  end
end
