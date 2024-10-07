class Admin::UsersController < Admin::BaseController

  def index
    @users = User.where.not(email: 'admin@absensiapp.com')
  end
end
