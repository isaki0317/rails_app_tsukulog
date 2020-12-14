class LoginMailer < ApplicationMailer
  def send_when_login(end_user)
    @end_user = end_user
    mail to: @end_user.email, subject: 'ログインが完了しました。'
  end
end
