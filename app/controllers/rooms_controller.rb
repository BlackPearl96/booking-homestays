class RoomsController < ApplicationController
    def new
      session[:room_params] ||= {}
      @room = Room.new
      @room.room_images.build
      @room.current_step = session[:room_step]
    end

    def create
      session[:room_params].deep_merge!(room_params) if room_params
      @room = current_member.rooms.build session[:room_params]
      @room.current_step = session[:room_step]
      if @room.valid?
        if params[:back_button]
          @room.previous_step
        elsif @room.last_step?
          @room.save if @room.all_valid?
          session[:room_params] = session[:room_step] = nil
          upload_images if params[:room_images]
          redirect_to manager_room_path(@room), success: t(".create_room")
          return
        else
          @room.next_step
        end
        session[:room_step] = @room.current_step
      end
      if @room.last_step?
        redirect_to new_manager_room_path
      else
        render :edit
      end
    end

    private

    def room_params
      params.require(:room).permit :name, :address, :rate_point, :description,
                                   :guest, :type_room, :acreage, :bed_room,
                                   :bath_room, :location_id, utility_ids: [],
                                   room_images_attributes: %i[id room_id image _destroy]
    end

    def upload_images
      params[:room_images]["image"].each do |a|
        @room_images = @room.room_images.create!(image: a)
      end
    end
end
