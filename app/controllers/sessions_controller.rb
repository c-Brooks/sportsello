class SessionsController < ApplicationController
  # This controller takes care of user signin/signout
  # Right now, only deals with FANS signing in/out thru FACEBOOK

  def new
  end

  def create
    # Facebook login
    if env["omniauth.auth"]
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_path
  else # email/password login
    user = User.find_by_email(params[:email])
      # If the user exists AND the password entered is correct.
      if user && user.authenticate(params[:password])
        # Save the user id inside the browser cookie. This is how we keep the user
        # logged in when they navigate around our website.
        session[:user_id] = user.id
        redirect_to '/'
      else
      # If user's login doesn't work, send them back to the login form.
        redirect_to new_session_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
