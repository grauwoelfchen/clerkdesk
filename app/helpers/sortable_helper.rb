module SortableHelper
  def sort_links_for(column, default = nil)
    content_tag(:ul, :class => "sort-links") do
      concat content_tag(:li, sort_link_for(column, :asc,  default == :asc))
      concat content_tag(:li, sort_link_for(column, :desc, default == :desc))
    end
  end

  def sort_link_for(column, direction, default_link = false)
    link = url_for(params.merge(column: column, direction: direction))
    icon = <<-ICON.gsub(/^\s*|\n/, "")
      <i class="#{sort_link_class_for(column, direction, default_link)}"></i>
    ICON
    link_to icon.html_safe, link
  end

  private

  # priority desc, updated_at
  # see also sortable module
  def sort_link_class_for(column, direction, default_link = false)
    klass = "fa fa-lg fa-angle-"
    if direction == :desc
      klass += "down"
    else
      klass += "up"
    end
    column_matched    = params[:column] == column.to_s
    direction_matched = params[:direction] == direction.to_s
    if (!params[:column] && !params[:direction] && default_link) ||
       (!params[:column] && default_link) ||
       (column_matched && !params[:direction] && direction == :desc) ||
       (column_matched && direction_matched)
      klass += " active"
    end
    klass
  end
end
