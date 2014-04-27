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

end
