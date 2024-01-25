module ApplicationHelper
  # Creates a link for sorting table columns in a view.
  #
  # @param title [String] The display text for the link.
  # @param column [String] The database column name used for sorting.
  # @return [String] HTML link for sorting with an icon indicating the sort order.
  def sort_link(title, column)
    # Determine the direction of sorting
    direction = params[:sort] == column && params[:direction] == 'asc' ? 'desc' : 'asc'

    # Determine the icon class to be used based on the current sorting state
    icon_class = if params[:sort] == column
                   params[:direction] == 'asc' ? 'fa fa-sort-up' : 'fa fa-sort-down'
                 else
                   'fa fa-sort'
                 end

    # Generate the link for sorting. The 'raw' method is used to render HTML properly.
    link_to articles_path(sort: column, direction: direction) do
      raw("#{title} <i class='#{icon_class}'></i>")  # Use 'raw' to render HTML properly.
    end
  end
end
