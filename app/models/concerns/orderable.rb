module Orderable
  extend ActiveSupport::Concern

  class_methods do
    # Specifies valid fields with optional default
    #
    #   orderable :name, :email
    #   orderable :name, :email, updated_at: :desc
    def orderable(*attributes)
      last = attributes.last
      @orderable_default_option = last if last.is_a?(Hash)
      @orderable_attributes = attributes.map { |a|
        a.is_a?(Hash) ? a.keys.map(&:to_s) : a.to_s
      }.flatten
    end

    def orderable_default_option
      option = @orderable_default_option
      unless option
        if :updated_at.in?(@orderable_attributes)
          option = {:updated_at => :desc}
        else
          option = {:id => :asc}
        end
      end
      option
    end

    def orderable_attributes
      @orderable_attributes || []
    end
  end

  included do
    private_class_method :orderable_default_option
    private_class_method :orderable_attributes

    # Orders by valid fields and direction.
    #
    #   Book.order_by(:author => :asc, :price => :desc)
    #   Book.order_by(params[:fld], params[:dir])
    scope :order_by, ->(single_field_or_options = nil, direction = nil) {
      if single_field_or_options.is_a?(Hash) && !direction
        fields = single_field_or_options
      else
        fields = single_field_or_options.to_s.split(',')
      end
      option = fields.inject({}) { |opt, fld|
        if fld.is_a?(Array)
          fld,dir = fld
        else
          dir = direction
        end
        if fld.in?(orderable_attributes)
          opt[fld] = (dir == 'desc') ? :desc : :asc
        end
        opt
      }
      option = orderable_default_option if option.blank?
      order(option)
    }
  end
end
