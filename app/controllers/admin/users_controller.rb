class Admin::UsersController < Admin::BaseController
  before_action :set_companies, only: [:new, :create]

  def index
    @users = User.where.not(email: 'admin@absensiapp.com')

    @companies = Company.all
    @q = @users.ransack(params[:q])
    @pagy, @users = pagy(@q.result, limit: 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "User updated successfully!"
      redirect_to admin_users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path
  end

  private

    def user_params
      params.require(:user).permit(:full_name, :email, :username)
    end
end
