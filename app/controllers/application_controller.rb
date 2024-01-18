class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    def route_not_found
        render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
    end

    # Render 404 HTML page if URL is invalid
    private
    def render_404
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
end
