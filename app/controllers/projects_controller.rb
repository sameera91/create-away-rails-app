class ProjectsController < ApplicationController
  def index
    if params[:user_id]
      @projects = User.find(params[:user_id]).projects
    else
      @projects = Project.all
    end
    @top_projects = Project.top_projects
  end
  
  def new
    @project = Project.new(user_id: params[:user_id])
  end

  def create
    @project = Project.create(project_params)
    if @project.save
      current_user.projects << @project
      redirect_to project_path(@project)
    else
      render "projects/new"
    end
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
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    if @project.save
      flash[:success] = "Project updated."
      redirect_to @project
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to projects_path
  end


  private

    def project_params
      params.require(:project).permit(:title, :user_id, :short_description, :long_description, category_ids:[], categories_attributes: [:name])
    end
end
