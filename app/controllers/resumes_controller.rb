class ResumesController < ApplicationController
   def index
      @resumes = Resume.where(:team_id => params[:team])
      @resumenew = Resume.new
      @team = Team.find(params[:team])
      @chats = current_user.chats.where(:team => params[:team])

   end

   def new
      @resume = Resume.new
   end

   def create
      @resume = Resume.new(resume_params)
      @resume.name="noname"
      if @resume.save
         redirect_to action: 'index', team: params[:resume][:team_id], notice: "#{@resume.attachment.file.filename} 가 업로드 되었습니다."
      else
         redirect_to action: 'index', team: params[:resume][:team_id], notice: "파일을 올려주세요."
      end

   end

   def destroy
      @resume = Resume.find(params[:id])
      team = @resume.team_id
      @resume.destroy
      redirect_to action: 'index', team: team#, notice:  "#{@resume.attachment.file.filename} 가 삭제 되었습니다."
   end

   private
      def resume_params
          params.require(:resume).permit(:name, :attachment, :team_id)

      end

end
