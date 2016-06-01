class TestController < ApplicationController
  def index
  end
  
  def invitation
    @team = Team.find(params[:team])
    if !@team.users.include?(current_user)
      redirect_to :root
    end
    if current_user!=nil
      redirect_to :root
    end
  end
  
  def regmail
    @new_user=User.where(:email => params[:email])
    new_user=@new_user
    @ment = ""
    if current_user!=nil
      redirect_to :root
    end
    if new_user[0]==nil
      NoticeMailer.regmail(params[:email]).deliver_now
      @ment=params[:email]+"로 초대장이 발송되었습니다. 메일을 확인해 보세요!!"
    else
      @ment=params[:email]+"는 이미 가입되어있는 이메일 입니다."
    end
  end
end
