class AcceptInvitationsController < ApplicationController
  def edit
    @user = User.find_by(invite_token: params[:invite_token])

    if @user.nil? || DateTime.now > (@user.invite_token_expired_at + 8.hours)
      flash[:danger] = "Invalid invitation token."
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(invite_token: params[:invite_token])
    @user.invite_token = nil
    @user.invite_token_expired_at = nil

    if @user.update(user_params)
      flash[:success] = "User updated successfully!"
      redirect_to sign_in_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:full_name, :email, :username, :password, :password_confirmation)
    end
end
