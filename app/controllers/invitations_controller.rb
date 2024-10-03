class InvitationsController < ApplicationController
  before_action :logged_in?
  before_action :company_owner?

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.username = @user.email
    @user.company = current_user.company
    @user.password = SecureRandom.hex(10)
    @user.invite_token = SecureRandom.hex(10)
    @user.invite_token_expired_at = DateTime.now + 8.hours

    if @user.save
      flash[:success] = "Invitation sent successfully!"
      redirect_to users_path
      InvitationMailer.with(user: @user).invite_new_user.deliver_later
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.password = SecureRandom.hex(10)
    @user.invite_token = SecureRandom.hex(10)
    @user.invite_token_expired_at = DateTime.now + 8.hours

    if @user.save
      flash[:success] = "New invitation sent successfully!"
      redirect_to users_path
      InvitationMailer.with(user: @user).re_invite_new_user.deliver_later
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:full_name, :email)
    end
end
