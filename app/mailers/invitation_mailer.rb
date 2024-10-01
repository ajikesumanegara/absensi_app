class InvitationMailer < ApplicationMailer
  def invite_new_user
    @user = params[:user]
    @url  = "http://localhost:3000/accept_invitations/#{@user.invite_token}"
    mail(to: @user.email, subject: "You are invited to join #{@user.company.name} as a Member")
  end

  def re_invite_new_user
    @user = params[:user]
    @url  = "http://localhost:3000/accept_invitations/#{@user.invite_token}"
    mail(to: @user.email, subject: "New invitation to join #{@user.company.name}")
  end
end
