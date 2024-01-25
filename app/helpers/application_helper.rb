module ApplicationHelper
  def sort_link(title, column)
    direction = params[:sort] == column && params[:direction] == 'asc' ? 'desc' : 'asc'
    icon_class = params[:sort] == column ? (params[:direction] == 'asc' ? 'fa fa-sort-up' : 'fa fa-sort-down') : 'fa fa-sort'
  
    link_to articles_path(sort: column, direction: direction) do
      raw("#{title} <i class='#{icon_class}'></i>")
    end
  end
  
end
