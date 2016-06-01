class TeamController < ApplicationController
  before_action :authenticate_user!

  def index

    @image = Imagemessage.all

    @team = current_user.teams
    @user = User.all
    if !current_user.teams.first
      redirect_to "/team/noteam"
    end

  end
  def create
    team = Team.new(:teamname => params[:teamname])
    team.users << current_user
    team.users << User.where(:id => params[:user_ids])
    if team.save
      redirect_to "/team/addmember?team="+team.id.to_s
    end
  end
  def newteam
    @team = current_user.teams
    @user = User.all
  end
  def addmember
    @team = Team.find(params[:team])
    @user = User.all
    if !@team.users.include?(current_user)
      redirect_to :root
    end
  end
  def adding
    if params[:team]!=nil
      @team = Team.find(params[:team])
      @new_user=User.where(:email => params[:user_email])
      new_user=@new_user
      @ment = ""
      if new_user[0]==nil
        NoticeMailer.invitation(params[:user_email], current_user, @team).deliver_now
        @ment=params[:user_email]+"로 가입된 회원이 아직 없네요! 메일 주소로 초대장을 보냈으니 회원가입 후 다시 초대해 보세요."
      elsif @team.users.where(:email => params[:user_email])[0]==nil
        @team.users << User.where(:email => params[:user_email])
        @ment=params[:user_email]+"(이름: "+new_user[0].first_name+")"+" 팀원으로 가입되었습니다!"
      else
        @ment=params[:user_email]+"로 가입된 회원은 이미 팀에 초대되어 있네요!"
      end
    else
      redirect_to :root
    end
  end
  def profile
    @team = current_user.teams
  end
  def profileupdate
    if(params[:image])
      current_user.image=params[:image]
    end
    if(params[:name]!="" and params[:name]!=nil)
      current_user.first_name=params[:name]
    end
    if(params[:lname]!="" and params[:lname]!=nil)
      current_user.last_name=params[:lname]
    end
    current_user.save
    redirect_to "/team/profile"
  end

  def deletemember
    team = Team.find(params[:team])
    chats = current_user.chats.where(:team_id => params[:team])
    chats.each do |chat|
      chat.users.delete(current_user)
    end
    team.users.delete(current_user)
    redirect_to :root
  end

  def noteam
    if current_user.teams.first
      redirect_to :root
    end
  end

  def change_etc1
    dd = Team.find(params[:team])
    dd.belong = params[:belong]
    dd.save
    redirect_to action: 'show', controller: 'chat', team: params[:team]
  end

  def change_etc2
    dd = Team.find(params[:team])
    dd.location = params[:location]
    dd.save
    redirect_to action: 'show', controller: 'chat', team: params[:team]
  end


end
