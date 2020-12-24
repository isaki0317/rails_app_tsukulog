class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def check_notice_mail
    @url = "https://tsukulog.com/users/sign_in(provisional)"

    users_with_unckecked_notices = EndUser.all.select do |end_user|
      end_user.passive_notifications.where(visited_id: end_user.id, checked: false).count >= 10
    end

    users_with_unckecked_notices_mails = users_with_unckecked_notices.pluck(:email)

    mail(subject: "未読の通知が10件以上あります", bcc: users_with_unckecked_notices_mails)
  end
end
