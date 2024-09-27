class UsersController < ApplicationController
  before_action :logged_in?, except: [:new, :create]
  before_action :has_company?
  before_action :company_owner?, except: [:edit, :update]

  def index
    @users = current_company.users
  end

  def new
    @user = User.new
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

  def updated
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
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:full_name, :email, :username, :password, :password_confirmation)
    end

end