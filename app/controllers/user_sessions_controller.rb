class UserSessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:primary] = "Welcome back #{@user.full_name}!"
      redirect_to root_path
    else
      flash[:danger] = "Login failed! Please try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end
  
end