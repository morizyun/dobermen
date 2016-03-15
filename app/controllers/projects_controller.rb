class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.active_order
  end

  # GET /projects/1/edit
  def edit
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to edit_project_path(@project), notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:email)
  end
end
