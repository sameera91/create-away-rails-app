class ProjectsController < ApplicationController
  def index
    if params[:user_id]
      @projects = User.find(params[:user_id]).projects
    else
      @projects = Project.all
    end
    @top_projects = Project.top_projects
    #render :text => request.env["omniauth.auth"].to_yaml
  end
  
  def new
    @project = Project.new(user_id: params[:user_id])
  end

  def create
    @project = Project.create(project_params)
    current_user.projects << @project
    redirect_to project_path(@project)
  end

  def show
    if params[:user_id]
      @project = User.find(params[:user_id]).projects.find(params[:id])
    else
      @project = Project.find(params[:id])
    end
  end

  def edit
    @project = Project.find(params[:id])
    @project.update_likes(params[:id])
    redirect_to project_path(@project)
  end

  private

    def project_params
      params.require(:project).permit(:title, :user_id, :short_description, :long_description, category_ids:[], categories_attributes: [:name])
    end
end
