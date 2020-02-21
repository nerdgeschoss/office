# frozen_string_literal: true

class Door
  class << self
    def find(id)
      id = id.to_s
      raise ActiveRecord::NotFound, "Door with id #{id} does not exist." unless ["front"].include?(id)
      Door.new(id: id)
    end
  end

  attr_reader :id

  def initialize(id:)
    @id = id
  end

  def slug
    id
  end

  def buzzing?
    false
  end

  def open!
  end
end
