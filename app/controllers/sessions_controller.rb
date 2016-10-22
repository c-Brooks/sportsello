class SessionsController < ApplicationController
  # This controller takes care of user signin/signout
  # Right now, only deals with FANS signing in/out thru FACEBOOK
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
