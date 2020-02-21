# frozen_string_literal: true

class DoorJob < ApplicationJob
  queue_as :door

  def perform(door_id)
    door = Door.find door_id
    if door.buzzing?
      door.start_buzzing!
      DoorJob.set(wait: 10).perform_later
    else
      door.stop_buzzing!
    end
  end
end