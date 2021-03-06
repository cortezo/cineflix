class UsersController < ApplicationController
  def new
    redirect_to home_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to sign_in_path
    else
      flash[:error] = "User creation failed."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end