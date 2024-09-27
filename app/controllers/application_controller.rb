class ApplicationController < ActionController::Base
  include Pagy::Backend
  helper_method :current_user
  helper_method :logged_in?
  helper_method :has_company?
  helper_method :company_owner?

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def current_company
    @current_company ||= current_user&.company
  end

  def logged_in?
    if current_user.blank?
      flash[:danger] = "You don't have an access! Please sign in first."
      redirect_to sign_in_path
    end
  end

  def has_company?
    if current_user.present?
      if current_user.company.blank?
        flash[:primary] = "Please create your company first!"
        redirect_to new_company_path
      end
    end
  end

  def company_owner?
    if current_user.present?
      if !current_user.as_owner
        flash[:danger] = "You don't have an access. You're not the company owner!"
        redirect_to root_path
      end
    end
  end
end
