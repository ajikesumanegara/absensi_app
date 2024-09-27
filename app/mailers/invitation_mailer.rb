class InvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite_new_user.subject
  #
  def invite_new_user(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
