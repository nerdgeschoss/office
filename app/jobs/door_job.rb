# frozen_string_literal: true

class DoorJob < ApplicationJob
  queue_as :door

  def perform(door_id)
    door = Door.find door_id
    while door.buzzing?
      door.start_buzzing!
      sleep 1
      door.stop_buzzing!
      sleep 1
    end
    door.stop_buzzing!
  end
end
