class MailerPreview < ActionMailer::Preview
  def notify
    Mailer.notify(User.first, Answer.first)
  end
end