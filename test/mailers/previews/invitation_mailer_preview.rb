# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invitation_mailer/invite_new_user
  def invite_new_user
    InvitationMailer.invite_new_user
  end

  def re_invite_new_user
    InvitationMailer.re_invite_new_user
  end

end
