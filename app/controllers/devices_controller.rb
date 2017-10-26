class DevicesController < ApplicationController
  before_action :load_device, except: [:index, :create]

  def destroy
    @device.destroy
    redirect_to @device.user
  end

  private

  def load_device
    @device = authorize Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name)
  end
end
