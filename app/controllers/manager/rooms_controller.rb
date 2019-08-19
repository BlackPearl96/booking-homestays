# frozen_string_literal: true

module Manager
  class RoomsController < BaseController
    before_action :load_room, only: %i(edit update show destroy)

    def index
      @rooms = Room.sort_by_name
    end

    def new
      @room = Room.new
      @room.room_images.build
    end

    def edit; end

    def show; end

    def create
      @room = current_admin.rooms.build room_params
      if @room.save
        upload_images
        redirect_to manager_room_path(@room), success: t(".create_room")
      else
        render :new, danger: t(".can't_create")
      end
    end

    def update
      if @room.update room_params
        upload_images if params[:room_images]
        redirect_to manager_room_path(@room), success: t(".update_success")
      else
        render :edit, danger: t(".update_fail")
      end
    end

    def destroy
      redirect_to manager_rooms_path, flash: {success: t(".deleted_success")} if @room.destroy
    end

    private

    def room_params
      params.require(:room).permit :name, :address, :rate_point, :description,
                                   :guest, :type_room, :acreage, :bed_room,
                                   :bath_room, :location_id,
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
  end
end
