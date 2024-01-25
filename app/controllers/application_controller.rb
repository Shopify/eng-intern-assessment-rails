class ApplicationController < ActionController::Base
    
    # Handling for RecordNotFound exceptions.
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
    private
  
    # Return with 404 Not Found for RecordNotFound exceptions.
    def record_not_found
        render plain: "404 Not Found", status: 404
    end

end
