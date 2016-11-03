class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render :json => @user
    else
      render :json => @user.errors
    end
  end

  private

  def user_params
    params[:email].downcase! if params[:email]
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
