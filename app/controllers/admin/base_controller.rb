class Admin::BaseController < ApplicationController
  before_action :logged_in?
  before_action :require_admin

  layout 'admin_application'

  private

    def require_admin
      if !current_user&.as_admin
        flash[:danger] = "You are not authorized to access this page."
        redirect_to root_path
      end
    end
end