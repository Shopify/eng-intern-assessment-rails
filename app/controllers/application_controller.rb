class ApplicationController < ActionController::Base
    # before_action executes before every controller action if the current controller is a Devise controller
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

end
