# ErrorsController: Handles common error responses

class ErrorsController < ApplicationController
    def not_found
        render plain: '404 Not Found', status: :not_found
    end

    def internal_server_error
        render plain: '500 Internal Server Error', status: :internal_server_error
    end
end