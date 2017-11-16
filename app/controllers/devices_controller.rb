class DevicesController < ApplicationController
  before_action :load_device, except: [:index, :create]

  def create
    @device = authorize Device.new device_params
    if @device.save
      redirect_to @device.user
    else
      @user = User.find(device_params[:user_id])
      render "users#show"
    end
  end

  def update
    @device.update! device_params
    redirect_to @device.user
  end

  def destroy
    @device.destroy
    redirect_to @device.user
  end

  private

  def load_device
    @device = authorize Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name, :user_id, :mac_address, :track_time)
  end
end
