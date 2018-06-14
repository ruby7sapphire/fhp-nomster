class NotificationMailer < ApplicationMailer
  default from: 'no-reply@nomsterapp.com'

  def comment_added
    mail(to: ENV['MAILTO_ADDRESS'],
         subject: 'A comment has been added to your place')
  end
end
