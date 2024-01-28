class Users::SessionsController < Devise::SessionsController
  # custom redirect hook
  def after_sign_in_path_for(resource)
    root_path
  end
end
