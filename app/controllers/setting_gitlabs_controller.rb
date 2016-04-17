class SettingGitlabsController < ApplicationController
  before_action :set_setting_gitlab, only: [:edit, :update, :destroy]

  # GET /setting_gitlabs
  def index
    @setting_gitlabs = SettingGitlab.all
  end

  # GET /setting_gitlabs/new
  def new
    @setting_gitlab = SettingGitlab.new
  end

  # GET /setting_gitlabs/1/edit
  def edit
  end

  # POST /setting_gitlabs
  def create
    @setting_gitlab = SettingGitlab.new(setting_gitlab_params)

    respond_to do |format|
      if @setting_gitlab.save
        format.html { redirect_to setting_gitlabs_url, notice: 'Setting gitlab was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /setting_gitlabs/1
  def update
    respond_to do |format|
      if @setting_gitlab.update(setting_gitlab_params)
        format.html { redirect_to setting_gitlabs_url, notice: 'Setting gitlab was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /setting_gitlabs/1
  def destroy
    @setting_gitlab.destroy
    respond_to do |format|
      format.html { redirect_to setting_gitlabs_url, notice: 'Setting gitlab was successfully destroyed.' }
    end
  end

  private
  # ------------------------------------------------------------------
  # Private Methods
  # ------------------------------------------------------------------
  # Use callbacks to share common setup or constraints between actions.
  def set_setting_gitlab
    @setting_gitlab = SettingGitlab.find_by_id!(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_gitlab_params
    params.require(:setting_gitlab).permit(:base_url, :ssh_key, :private_token)
  end
end
