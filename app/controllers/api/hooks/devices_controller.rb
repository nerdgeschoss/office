module API
  module Hooks
    class DevicesController < HooksController
      def online
        addresses = params[:mac_addresses].to_a
        Device.where(mac_address: addresses).each(&:track_activity)
      end
    end
  end
end
