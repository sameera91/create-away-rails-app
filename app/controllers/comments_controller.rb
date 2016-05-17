class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new(project_id: params[:project_id])
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      current_user.comments << @comment
    end
    @project = Project.find(@comment.project_id)
    redirect_to project_path(@project)
  end

  def show
    @comment = Comment.find(params[:id])
    @project = Project.find(@comment.project_id)
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment deleted"
    redirect_to comments_path
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :project_id, :user_id, user_attributes:[:username])
    end
end
