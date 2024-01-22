class Writers::SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource)
      # Overrides the after_sign_in_path_for method from Devise.
      # Defines the redirection path after a writer successfully signs in.
      root_path
    end
end