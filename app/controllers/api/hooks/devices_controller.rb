module API
  module Hooks
    class DevicesController < HooksController
      def online
        Device.where(mac_address: params[:mac_addresses].to_a).update_all last_activity_at: DateTime.current
      end
    end
  end
end
