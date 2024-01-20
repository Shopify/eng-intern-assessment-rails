class Writers::SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource)
      root_path # Or any other path
    end

    def sign_out
        redirect_to destroy_writer_session_path
    end
end