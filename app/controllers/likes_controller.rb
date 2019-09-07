# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_member!
  before_action :load_room, only: %i[create destroy]
  before_action :load_unlike, only: :destroy

  def create
    unless check_like?
      @like = current_member.likes.create(room_id: @room.id)
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
      end
    end
  end

  def destroy
    if check_like? && @unlike.destroy
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js
      end
    else
      flash[:danger] = t "controller.likes.unlike_fail"
      redirect_to request.referrer
    end
  end

  def wishlist
    @room_like = current_member.likes.includes(:user).pluck(:room_id)
    @wishlist = Room.includes(:location, :favorite_space).by_like_room @room_like
  end

  private

  def check_like?
    Like.by_like_member(current_member.id, params[:room_id]).exists?
  end

  def load_room
    @room = Room.find params[:room_id]
  end

  def load_unlike
    @unlike = current_user.likes.find_by(room_id: @room.id)
  end
end
