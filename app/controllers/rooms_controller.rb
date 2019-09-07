# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_member!

  def new
    session[:room_params] ||= {}
    @room = Room.new
    get_area_to_location
    @room.room_images.build
    @room.current_step = session[:room_step]
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

  def destroy
    @room = Room.find params[:id]
    if @room.destroy
      flash[:success] = t ".del_success"
    else
      flash[:danger] = t ".del_fail"
    end
    redirect_to index_profile_path(current_member)
  end

  private

  def room_params
    params.require(:room).permit :name, :address, :rate_point, :description,
                                 :guest, :type_room, :acreage, :bed_room,
                                 :favorite_space_id, :code_room, :bath_room,
                                 :location_id, :area_id, utility_ids: [],
                                 room_images_attributes: %i[id room_id image _destroy]
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

  def get_area_to_location
    @areas = []
    if params[:location].present?
      @areas = Location.find(params[:location]).areas
    end
    if request.xhr?
      respond_to do |format|
        format.json { render json: {areas: @areas} }
      end
    end
  end
end
