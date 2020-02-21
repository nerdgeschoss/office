# frozen_string_literal: true

class ChangeActivityJob < ApplicationJob
  queue_as :low_priority

  def perform(attributes)
    ChangeActivity.create!(attributes)
  end
end
