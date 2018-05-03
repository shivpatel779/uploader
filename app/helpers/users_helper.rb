module UsersHelper

  def sortable(column, title=nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = params[:direction]=="asc" ? "desc" : "asc"
    link_to title, { search: params[:search], sort:column, direction:direction, page:nil}, { class: css_class }
  end

end
