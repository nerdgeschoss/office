# frozen_string_literal: true

class Door
  class << self
    def find(id)
      id = id.to_s
      raise ActiveRecord::NotFound, "Door with id #{id} does not exist." unless ["front"].include?(id)

      Door.new(id: id)
    end

    def redis
      @redis ||= Redis.new
    end
  end

  attr_reader :id

  delegate :redis, to: :class

  def initialize(id:)
    @id = id
  end

  def slug
    id
  end

  def buzzing?
    redis.get(redis_key) == "true"
  end

  def open!
    redis.set(redis_key, "true", ex: 20)
    DoorJob.perform_later(id)
  end

  def start_buzzing!
    ensure_running_on_hardware
    door_buzzer.turn_off! # this seems to be inverted on the board
  end

  def stop_buzzing!
    ensure_running_on_hardware
    door_buzzer.turn_on! # this seems to be inverted on the board
  end

  private

  def ensure_running_on_hardware
    raise StandardError, "Cannot buzz the door, you're not running on hardware" unless Rails.application.config.raspi
  end

  def redis_key
    @redis_key ||= ["door", id, "buzzing"].join(":")
  end

  def door_buzzer
    @door_buzzer ||= GPIO::Led.new(17)
  end
end
