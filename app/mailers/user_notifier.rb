class UserNotifier < ApplicationMailer
  default :from => 'trantrongphu1983@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
          :subject => 'Thanks for signing up for our amazing app' )
  end

  def send_email(user,email_title,email_content)
      @user = user
      mail(
          :to => @user.email,
          :subject => email_title,
          :body => email_content
      )
  end

end
