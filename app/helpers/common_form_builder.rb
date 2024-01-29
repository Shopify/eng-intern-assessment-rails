class CommonFormBuilder < ActionView::Helpers::FormBuilder
  # Produces the HTML for an input field's errors
  def render_field_with_errors(attribute)
    errors = @object.errors.full_messages_for(attribute)
    return if errors.empty?
      
    # Enclose each error message in a div, then join them as a single HTML string
    errors.map { |message| @template.content_tag(:div, message) }.join.html_safe
  end
end
