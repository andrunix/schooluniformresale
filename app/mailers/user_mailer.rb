class UserMailer < ApplicationMailer

  default from: "hello@schooluniformresale.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invitation.subject
  #

  def invitation(email, message, sender)
    @message = message
    @sender = sender
    mail to: email, subject: "Invitation to join School Uniform Resale"
  end
end
