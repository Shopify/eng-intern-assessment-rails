class Users::RegistrationsController < Devise::RegistrationsController
  # custom redirect hook
  def after_sign_up_path_for(resource)
    root_path
  end
end
