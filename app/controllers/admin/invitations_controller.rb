class Admin::InvitationsController < Admin::BaseController
  before_action :set_companies, only: [:new, :create]

  def new
    @user = User.new
    @company = Company.new
  end

  def create
    if params[:set_as_owner]
      @company = Company.new(company_params)

      if @company.save
        @user = User.new(params.require(:user).permit(:full_name, :email))
        @user.company = @company
        @user.as_owner = true
        assign_user_invite_details

        if @user.save
          flash[:success] = "Invitation sent successfully!"
          redirect_to admin_users_path
          InvitationMailer.with(user: @user).invite_user_with_company.deliver_later
        else
          render :new, status: :unprocessable_entity
        end
      else
        render :new, status: :unprocessable_entity
      end
    else
      @user = User.new(params.require(:user).permit(:full_name, :email, :company_id))
      @user.company = Company.find(@user.company_id)
      assign_user_invite_details

      if @user.save
        flash[:success] = "Invitation sent successfully!"
        redirect_to admin_users_path
        InvitationMailer.with(user: @user).invite_new_user.deliver_later
      else
        render :new, status: :unprocessable_entity
      end
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
      redirect_to admin_users_path
      InvitationMailer.with(user: @user).re_invite_new_user.deliver_later
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_companies
    @companies = Company.all
  end

  def company_params
    params.require(:company).permit(:name)
  end

  def assign_user_invite_details
    @user.username = @user.email
    @user.password = SecureRandom.hex(10)
    @user.invite_token = SecureRandom.hex(10)
    @user.invite_token_expired_at = DateTime.now + 8.hours
  end
end