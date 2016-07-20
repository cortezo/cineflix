class SessionsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.find_by_email(params[:email])

    # user.authenticate method is provided by "has_secure_password" in user model
    if user && user.authenticate(params[:password])
      # Use the user.id because we don't want to put the whole user object in the cookie
      # because cookies have limited size contraints and an entire object is large.
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.full_name}."
      redirect_to root_path
    else
      flash[:info] = "We had trouble logging you in.  Please try again."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil

    flash[:info] = "You have logged out."
    redirect_to root_path
  end
end