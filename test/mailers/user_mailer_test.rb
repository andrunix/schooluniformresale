require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "invitation" do
    mail = UserMailer.invitation("to@example.org", "Hi", "Andrew Pierce")
    assert_equal "Invitation to join School Uniform Resale", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["hello@schooluniformresale.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
