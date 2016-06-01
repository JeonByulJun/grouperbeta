class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.invitation.subject
  #
  def invitation(email, inviter, team)
    @inviter=inviter
    @team=team
    @email=email
    @auth=email.hash
    mail to: email, subject: "그루퍼에서 초대장이 왔습니다."
  end
  def regmail(email)
    @email=email
    @auth=email.hash
    mail to: email, subject: "그루퍼에서 초대장이 왔습니다."
  end
end
