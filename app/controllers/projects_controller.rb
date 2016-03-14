class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.active_order
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/1/edit
  def edit
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
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
    params.require(:project).permit(:name, :url)
  end
end
