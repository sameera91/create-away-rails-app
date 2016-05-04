class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new(project_id: params[:project_id])
  end

  def create
    @comment = Comment.create(comment_params)
    redirect_to comment_path(@comment)
  end

  def show
    @comment = Comment.find(params[:id])
    @project = Project.find(@comment.project_id)
    redirect_to project_path(@project)
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :project_id, :user_id, user_attributes:[:username])
    end
end
