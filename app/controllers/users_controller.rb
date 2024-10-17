class UsersController < ApplicationController
  before_action :logged_in?, except: [:new, :create]
  before_action :has_company?
  before_action :company_owner?, except: [:show, :edit, :update]

  def index
    @users = current_company.users

    @q = @users.ransack(params[:q])
    @pagy, @users = pagy(@q.result, limit: 10)
  end

  def new
    if current_user
      redirect_to new_invitation_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User created successfully!"
      redirect_to sign_in_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])

    if current_user != @user && !current_user.as_owner
      flash[:danger] = "You don't have an access to other people's profile settings!"
      redirect_to root_path
    end

  end

  def update
    @user = User.find(params[:id])

    if current_user == @user || current_user.as_owner
      if @user.update(user_params)
        flash[:success] = "User updated successfully!"
        redirect_to @user
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:danger] = "You don't have permission to update this profile!"
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])

    if current_user.company_id == @user.company_id
      if current_user != @user && !current_user.as_owner
        flash[:danger] = "You don't have an access to other people's profile settings!"
        redirect_to root_path
      end
    else
      flash[:danger] = "You can't access user from another company!"
      redirect_to root_path
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.as_owner
      flash[:danger] = "You can't delete your own account!"
      redirect_to users_path
    else
      if @user.attendances.any?
        @user.attendances.destroy_all
      end
      @user.destroy
      flash[:success] = "User successfully deleted!"
      redirect_to users_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:full_name, :email, :username, :password, :password_confirmation)
    end

end