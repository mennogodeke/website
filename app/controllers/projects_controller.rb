class ProjectsController < ApplicationController
  def index
    @projects = Project.includes(:skills).all
  end

  def show
    @project = Project.includes(:skills).find(params[:id])
  end
end
