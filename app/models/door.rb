# frozen_string_literal: true

class Door
  class << self
    def find(id)
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
