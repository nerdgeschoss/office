class DevicesController < ApplicationController
  before_action :load_device, except: [:index, :new, :create]

  def new
    @device = authorize Device.new user_id: current_user.id
  end

  def create
    @device = authorize Device.new device_params.merge(last_activity_at: DateTime.current)
    if @device.save
      close_modal
    else
      render_modal :new
    end
  end

  def update
    if @device.update device_params
      close_modal
    else
      render_modal :edit
    end
  end

  def destroy
    @device.destroy
    refresh
  end

  private

  def load_device
    @device = authorize Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name, :user_id, :mac_address, :track_time)
  end
end
