class CommentsController < ApplicationController
  def index
    if(params[:project_id])
      @project = Project.find(params[:project_id])
    end
    @comments = @project.comments
  end

  def new
    @comment = Comment.new(project_id: params[:project_id])
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      @project = Project.find(@comment.project_id)
      current_user.comments << @comment
      @project.comments.build(comment_params)
      render json: @comment, status: 201
      #redirect_to project_path(@project)
    else
      render "comments/new"
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @project = Project.find(@comment.project_id)
    @user_name = User.find(@comment.user_id).name
=begin
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @comment }
    end
=end
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
    @comment = Comment.find(params[:id])
    @comment.destroy
    @project = Project.find(@comment.project_id)
    flash[:success] = "Comment deleted."
    redirect_to project_path(@project)
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :project_id, :user_id, user_attributes:[:username])
    end
end
