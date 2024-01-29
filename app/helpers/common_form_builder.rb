class CommonFormBuilder < ActionView::Helpers::FormBuilder
  def render_field_with_errors(attribute)
    errors = @object.errors.full_messages_for(attribute)
    return if errors.empty?
      
    errors.map { |message| @template.content_tag(:div, message) }.join.html_safe
  end
end