# frozen_string_literal: true

module Manager
  class RoomsController < BaseController
    before_action :load_room, only: %i[edit update show destroy]

    def index
      @rooms = Room.sort_by_name
    end

    def new
      session[:room_params] ||= {}
      @room = Room.new(session[:room_params])
      @room.room_images.build
      @room.current_step = session[:room_step]
    end

    def edit
      @room.room_images.build
      @room.current_step = session[:room_step]
    end

    def show
      @room_utilities = @room.utilities
    end

    def create
      session[:room_params].deep_merge!(room_params) if room_params
      @room = current_admin.rooms.build session[:room_params]
      @room.current_step = session[:room_step]
      return redirect_to manager_room_path(@room), success: t(".create_room") if btn_action_step @room

      if @room.last_step?
        redirect_to new_manager_room_path
      else
        render :new
      end
    end

    def update
      @room.update room_params
      @room.current_step = session[:room_step]
      return redirect_to manager_room_path(@room), success: t(".update_success") if btn_action_step @room

      if @room.last_step?
        redirect_to edit_manager_room_path
      else
        render :edit
      end
    end

    def destroy
      redirect_to manager_rooms_path, success: t(".deleted_success") if @room.destroy
    end

    private

    def room_params
      params.require(:room).permit :name, :address, :rate_point, :description,
                                   :guest, :type_room, :acreage, :bed_room,
                                   :bath_room, :location_id, utility_ids: [],
                                                             room_images_attributes: %i[id room_id image _destroy]
    end

    def load_room
      @room = Room.find params[:id]
    end

    def upload_images
      params[:room_images]["image"].each do |a|
        @room_images = @room.room_images.create!(image: a)
      end
    end

    def btn_action_step(room)
      if room.valid?
        if params[:back_button]
          room.previous_step
        elsif room.last_step?
          room.save if room.all_valid?
          session.delete(:room_step)
          session.delete(:room_params)
          upload_images if params[:room_images]
          return true
        else
          room.next_step
        end
        session[:room_step] = room.current_step
      end
      false
    end
  end
end
