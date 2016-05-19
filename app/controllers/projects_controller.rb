class ProjectsController < ApplicationController
  def index
    if params[:user_id]
      @projects = User.find(params[:user_id]).created_projects
    else
      @projects = Project.all
    end
    @trending_projects = Project.trending_projects
  end
  
  def new
    @project = Project.new(user_id: params[:user_id])
  end

  def create
    @project = Project.create(project_params)
    @project.user_id = current_user.id
    if @project.save
      current_user.created_projects << @project
      redirect_to project_path(@project)
    else
      render "projects/new"
    end
  end

  def show
    if params[:user_id]
      @project = User.find(params[:user_id]).created_projects.find(params[:id])
    else
      @project = Project.find(params[:id])
    end
    @user_name = User.find(@project.user_id).name
  end

  def edit
    @project = current_user.created_projects.find(params[:id])
  end

  def like
    @project = Project.find(params[:project_id])
    @project.update_likes(params[:project_id])
    redirect_to @project
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    if @project.save
      flash[:success] = "Project successfully updated."
      redirect_to @project
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Project successfully deleted."
    redirect_to projects_path
  end


  private

    def project_params
      params.require(:project).permit(:title, :user_id, :image, :short_blurb, :location, category_ids:[], categories_attributes: [:name])
    end
end
