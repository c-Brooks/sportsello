class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
    end
    redirect_to root_path
  end

  private

  def user_params
    params[:email].downcase!
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
