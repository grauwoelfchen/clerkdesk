module Shared
  module SortLinkHelper
    def sort_links_for(field, default=nil, css_class='links')
      content_tag(:ul, :class => css_class) do
        concat content_tag(:li, sort_link_for(field, :asc,  default == :asc))
        concat content_tag(:li, sort_link_for(field, :desc, default == :desc))
      end
    end

    def sort_link_for(field, direction, default_link=false)
      link = url_for(params.merge(field: field, direction: direction))
      icon = <<-ICON.gsub(/^\s*|\n/, '')
        <i class="#{sort_link_class_for(field, direction, default_link)}"></i>
      ICON
      link_to(icon.html_safe, link)
    end

    private

    # priority desc, updated_at
    # see also sortable module
    def sort_link_class_for(field, direction, default_link=false)
      klass = 'fa fa-lg fa-angle-'
      klass += (direction == :desc) ? 'down' : 'up'
      field_matched     = params[:field] == field.to_s
      direction_matched = params[:direction] == direction.to_s
      if (!params[:field] && !params[:direction] && default_link) ||
         (!params[:field] && default_link) ||
         (field_matched && !params[:direction] && direction == :desc) ||
         (field_matched && direction_matched)
        klass += ' active'
      end
      klass
    end
  end
end
