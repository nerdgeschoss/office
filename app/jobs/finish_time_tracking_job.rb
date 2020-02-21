# frozen_string_literal: true

class FinishTimeTrackingJob < ApplicationJob
  def perform
    PresenceTime.ready_for_close.each(&:close)
  end
end
