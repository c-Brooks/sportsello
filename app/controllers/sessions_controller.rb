class SessionsController < ApplicationController
  # This controller takes care of user signin/signout
  # Right now, only deals with FANS signing in/out thru FACEBOOK

  def new
  end

  def create
    # Facebook login
    if env["omniauth.auth"]
      @user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = @user.id
      redirect_to dev_path
    elsif params[:uid]
      @user = User.find_by_uid(params[:uid])
      session[:user_id] = @user.id
      render :json => @user
  else # email/password login
    @user = User.find_by_email(params[:email])
      # If the user exists AND the password entered is correct.
      if @user && @user.authenticate(params[:password])
        # Save the user id inside the browser cookie. This is how we keep the user
        # logged in when they navigate around our website.
        session[:user_id] = @user.id
        render :json => @user
      else
        render :json => @user.errors
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
