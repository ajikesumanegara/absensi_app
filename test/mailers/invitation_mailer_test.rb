require "test_helper"

class InvitationMailerTest < ActionMailer::TestCase
  test "invite_new_user" do
    mail = InvitationMailer.invite_new_user
    assert_equal "Invite new user", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
