module ApplicationHelper
    def display_devise_errors(resource)
        return '' if resource.errors.empty?
    
        messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
        html = <<-HTML
        <div class="alert alert-error">
          <ul>#{messages}</ul>
        </div>
        HTML
    
        html.html_safe
      end
end
