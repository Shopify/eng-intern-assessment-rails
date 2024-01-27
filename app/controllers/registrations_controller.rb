class User::RegistrationsController < Devise::RegistrationsController
    # This class is a custom controller that inherits from Devise's RegistrationsController.

    def after_sign_up_path_for(resource)
        # Overrides Devise's after_sign_up_path_for method.
        # Specifies the path the user should be redirected to after signing up.
        root_path
    end
end
