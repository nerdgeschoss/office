# frozen_string_literal: true

class DoorsController < ApplicationController
  before_action :set_door, only: :open

  def open
    @door.open!
    refresh
  end

  private

  def set_door
    @door = authorize Door.find(params[:id])
  end
end
