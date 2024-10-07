class UserSessionsController < ApplicationController

  def new
    if current_user
      flash[:primary] = "You are already signed in!"
      if current_user.as_admin
        redirect_to admin_dashboard_path
      else
        redirect_to root_path
      end
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:primary] = "Welcome back #{@user.full_name}!"
      if @user.as_admin
        redirect_to admin_dashboard_path
      else
        redirect_to root_path
      end
    else
      flash[:danger] = "Login failed! Please try again."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:primary] = "You have successfully logged out."
    redirect_to root_path
  end
  
end