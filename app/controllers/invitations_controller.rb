class InvitationsController < ApplicationController
  before_action :logged_in?
  before_action :company_owner?

  def new
    @user = User.new
  end

  def create

  end
end
