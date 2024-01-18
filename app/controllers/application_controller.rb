class ApplicationController < ActionController::Base
  # Handle invalid routes
  def handle_invalid_route
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
    end
  end
end
