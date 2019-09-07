# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  layout "application"

  def index
    @rooms = current_member.rooms.newest
  end

  def show
    @room = Room.find params[:id]
    @room_utilities = @room.utilities
  end

  protected

  def after_update_path_for(resource)
    index_profile_path(resource)
  end
end
