class LikesController < ApplicationController

  def new 
    @like = Like.new
  end

  def create
    @like = Like.create(project_id: params[:project_id])
    @project = Project.find_by(params[:project_id])
    @project.likes << @like
    redirect_to project_path(@project)
  end

end
