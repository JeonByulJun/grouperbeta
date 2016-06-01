class TaskController < ApplicationController
  def create
    if params[:user_ids]
      @task = Task.new(:taskname => params[:taskname], :duedate => params[:duedate])
      @task.users << User.where(:id => params[:user_ids])
      @task.sender = current_user.id
      @task.wansungdo = 0
      @task.team_id = params[:team]
      if @task.save
        redirect_to action: 'show', controller: 'chat', team: params[:team]
      end
    else
      redirect_to action: 'show', controller: 'chat', team: params[:team]
    end
  end

  def show
    task1 = Task.where(:sender => current_user.id)
    @tasksend = task1.where(:team_id => params[:team]).order(duedate: :asc)
    task2 = current_user.tasks
    @taskdo = task2.where(:team_id => params[:team])
    @task100 = task2.where(:wansungdo => 100).order(duedate: :asc)
    @tasklist = @taskdo.order(duedate: :asc)
    @tasklistdesc = @taskdo.order(duedate: :desc)
    @team = Team.find(params[:team])
    if !@team.users.include?(current_user)
      redirect_to :root
    end
    @chats = current_user.chats.where(:team => params[:team])
  end

  def entire
    @managelist = Task.order(duedate: :asc)
    @managelistdesc = Task.order(duedate: :desc)
    @team = Team.find(params[:team])
    @teamtask = Task.where(:team_id => params[:team])
    if !@team.users.include?(current_user)
      redirect_to :root
    end
  end

  def wansungdo_update
    @task = Task.find(params[:task_id])
    @task.wansungdo = params[:wansungdo]
    @comment = Comment.create(task_id: params[:task_id], wansungdo_log: params[:wansungdo], comment_log: params[:comment])
    @task.comments << @comment
    if @task.save
      redirect_to action: 'show', team: params[:team_id]
    end
  end
end
