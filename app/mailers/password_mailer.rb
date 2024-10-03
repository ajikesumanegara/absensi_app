class PasswordMailer < ApplicationMailer
  def reset_password
    @user = params[:user]
    @url = "http://localhost:3000/reset_password/#{@user.reset_password_token}"
    mail(to: @user.email, subject: "Reset Your Password")
  end
end
