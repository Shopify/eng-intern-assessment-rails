class Users::SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource)
      root_path
    end
end
