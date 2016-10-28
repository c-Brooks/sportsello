class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash.alert = 'Unsuccessful user creation...'
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params[:email].downcase!
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
