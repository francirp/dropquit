class SiteMailer < ActionMailer::Base
  default from: "support@dropquit.com"

  def self.admin_email_address
    'ryan@launchpadlab.com'
  end

  def user_commented(comment)
    @comment = comment
    @user_to_email = comment.commentable.user
    @user_that_commented = comment.user
    correct_email = Rails.env.production? ? @user_to_email.email : SiteMailer.admin_email_address
    mail(
      to: correct_email,
      subject: "#{@user_that_commented.handle} Commented On Your Post"
      )
  end

  def roll_call_reminder(user)
    @user = user
    correct_email = Rails.env.production? ? @user.email : SiteMailer.admin_email_address
    mail(
      to: correct_email,
      subject: "Reminder To Post Roll Call"
      )
  end

  def notify_admin_of_new_user(user)
    @user = user
    mail(
      to: SiteMailer.admin_email_address,
      subject: "New User!"
      )
  end

end
