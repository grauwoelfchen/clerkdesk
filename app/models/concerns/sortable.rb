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
    scope :ordered, ->(column = nil, direction = nil) {
      field = column.in?(self.sortable_attributes) ? column : "updated_at"
      order(field => (!column || direction == "desc") ? :desc : :asc)
    }
  end
end
