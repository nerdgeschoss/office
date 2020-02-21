# frozen_string_literal: true

module API
  module Hooks
    class HooksController < ActionController::API
      include Pundit
      force_ssl if: -> { Rails.env.production? }
    end
  end
end
