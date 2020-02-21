# frozen_string_literal: true

class DoorbellRingingJob < ApplicationJob
  def perform
    sleep 20
  end
end
