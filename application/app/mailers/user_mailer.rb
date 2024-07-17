class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.test_email.subject
  #
  default from: 'Blog-noReply@example.com'

  def test_email
    mail(to: 'recipient@example.com', subject: 'Test Email', body: 'This is a test email.')
  end
end
