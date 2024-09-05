class ApplicationController < ActionController::Base
  include ErrorHandler

  # Handle invalid routes
  def handle_invalid_route
    render_not_found
  end
end
