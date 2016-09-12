class DailyMailerPreview < ActionMailer::Preview

  def digest
    user = User.first
    DailyMailer.digest(user)
  end
end