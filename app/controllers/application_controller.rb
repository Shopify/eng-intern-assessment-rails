class ApplicationController < ActionController::Base
    # This before_action is a callback that runs before every controller action.
    # Here, it's set to run the :configure_permitted_parameters method before every action,
    # but only if the current controller is a Devise controller (i.e., related to user authentication).
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    # This method customizes Devise's strong parameter feature, which is used to control
    # which parameters are allowed to be used in Active Model mass assignments.
    # It's a security feature to prevent accidentally allowing users to update sensitive model attributes.
    def configure_permitted_parameters

        # The following line allows :name to be included in the parameters during a :sign_up action.
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        # This line allows :name to be included in the parameters during an :account_update action.
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

end