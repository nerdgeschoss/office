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
    @buzzing ||= redis.get(["door", id, "buzzing"].join(":")) == "true"
  end

  def open!
    redis.set(["door", id, "buzzing"].join(":"), "true", ex: 20)
  end
end
