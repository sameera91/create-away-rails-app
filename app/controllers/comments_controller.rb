class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new(project_id: params[:project_id])
  end

  def create
    @comment = Comment.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @project = Project.find(@comment.project_id)
      current_user.comments << @comment
      @project.comments.build(comment_params)
      redirect_to project_path(@project)
    else
      render "comments/new"
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @project = Project.find(@comment.project_id)
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    if @comment.save
      flash[:success] = "Comment updated."
      redirect_to @comment
    end
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
