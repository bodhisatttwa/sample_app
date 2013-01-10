class UserMailer < ActionMailer::Base
  default from: "kontakt@tomaszkaluzny.pl"

  def new_follower_notification(user, following_user)
    @user = user
    @following_user = following_user
    mail(to: user.email, subject: "New follower")
  end
end
