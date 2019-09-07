# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_member!

  def index
    @rooms = current_member.rooms.newest
  end

  def show
    @room = Room.find params[:id]
    @room_utilities = @room.utilities
  end
end
