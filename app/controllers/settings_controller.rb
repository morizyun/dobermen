class SettingsController < ApplicationController
  # GET /setting
  def show
    @setting = Setting.where(id: 1).first_or_initialize
  end

  # PATCH/PUT /setting
  def update
    @setting = Setting.where(id: 1).first_or_initialize

    respond_to do |format|
      if @setting.update(admin_params)
        format.html { redirect_to setting_show_path, notice: 'Setting was successfully updated.' }
      else
        format.html { render :show }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.require(:setting).permit(:email, :ssh_key)
  end
end
