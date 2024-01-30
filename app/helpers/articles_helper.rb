module ArticlesHelper
  def display_errors_for_field(object, field)
    if object.errors.any?
      object.errors.full_messages_for(field).each do |message|
        concat content_tag(:div, message, class: 'text-danger')
      end
    end
  end
end
