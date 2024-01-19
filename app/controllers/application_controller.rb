class ApplicationController < ActionController::Base
    # Handle invalid routes
    def handle_invalid
        render plain: '404 Not Found', status: :not_found
    end
end
