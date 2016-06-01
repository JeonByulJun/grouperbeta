class ChatController < ApplicationController
  def create
    @chat = Chat.new(:title => params[:title])
    @team = Team.find(params[:team])
    @team.chats << @chat
    @team.save
    @chat.users << current_user
    @chat.users << User.where(:id => params[:user_ids])
    if @chat.save
      @chat.whiteboard = Whiteboard.create(:edit => false, :content => "")
      @chat.whiteboard.user = current_user
      @chat.save
      redirect_to action: 'show', team: params[:team]
    else
      redirect_to action: 'show', team: params[:team]

    end
  end
  def show
    @team = Team.find(params[:team])
    @chats = current_user.chats.where(:team_id => params[:team])
    @managelist = Task.order(duedate: :asc)
    @managelistdesc = Task.order(duedate: :desc)
    @teamtask = Task.where(:team_id => params[:team]).order(duedate: :asc)

    if !@team.users.include?(current_user)
      redirect_to :root
    end
  end

  def deletemember
    chat = Chat.find(params[:chat])
    chat.users.delete(current_user)
    redirect_to action: 'show', team: params[:team]
  end
  def addmember
    @chat = Chat.find(params[:chat])
    @chat.users << User.where(:id => params[:user_ids])
    if @chat.save
      redirect_to action: 'show', controller: 'message', team: params[:team], chat: params[:chat]
    else
      redirect_to action: 'show', controller: 'message', team: params[:team], chat: params[:chat]
    end
  end

end
