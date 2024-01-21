class SessionsController < ApplicationController
  # Uses omniauth (Google provider) to keep track of user's session
  # Also provides important session fields
  def omniauth
    auth = request.env['omniauth.auth']
    user = User.where(provider: auth['provider'], uid: auth['uid']).first_or_initialize
    user.update(
      name: auth['info']['name'],
      email: auth['info']['email'],
      image: auth['info']['image']
    )
    session[:user_id] = user.id
    redirect_to root_path
  end

  # Destroys the user session on user logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
