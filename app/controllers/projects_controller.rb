class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end
  
  def new
    @project = Project.new(user_id: params[:user_id])
  end

  def create
    @project = Project.create(project_params)
    redirect_to project_path(@project)
  end

  def show
    @project = Project.find(params[:id])
  end

  private

    def project_params
      params.require(:project).permit(:title, :user_id, :short_description, :long_description, category_ids:[], categories_attributes: [:name])
    end
end
