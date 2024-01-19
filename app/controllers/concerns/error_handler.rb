module ErrorHandler
  extend ActiveSupport::Concern
  # Renders a 404 Not Found error.
  def render_not_found
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
    end
  end
end
