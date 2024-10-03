class PasswordsController < ApplicationController

  def new
    
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user
      @user.reset_password_token = SecureRandom.hex(10)
      @user.reset_password_token_expired_at = DateTime.now + 8.hours
      
      if @user.save
        flash[:success] = "Your password reset request has been received. Please check your email for the password reset link."
        redirect_to sign_in_path
        PasswordMailer.with(user: @user).reset_password.deliver_later
      end
        
    else
      flash[:danger] = "Your email address is not linked with any account"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(reset_password_token: params[:reset_password_token])

    if @user.nil? || DateTime.now > @user.reset_password_token_expired_at
      flash[:danger] = "Invalid reset password token."
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:reset_password_token])
    @user.reset_password_token = nil
    @user.reset_password_token_expired_at = nil
    @user.password_required!

    if @user.update(user_params)
      flash[:success] = "Password updated successfully!"
      redirect_to sign_in_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end
