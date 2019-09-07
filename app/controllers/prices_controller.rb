# frozen_string_literal: true

class PricesController < ApplicationController
  before_action :authenticate_member!

  before_action :load_price, only: %i[edit update destroy]
  before_action :load_room, only: %i[edit create update new]

  def index
    @prices = Price.newest
  end

  def edit
    @price.vouchers.build
  end

  def new
    @price = Price.new
    @price = @room.build_price
    @price.vouchers.build
  end

  def create
    @price = Price.new price_params
    if @price.save
      redirect_to show_profile_path(current_member, @room), flash: { success: t(".success") }
    else
      render :new
    end
  end

  def update
    if @price.update price_params
      redirect_to show_profile_path(current_member, @room), flash: { success: t(".success") }
    else
      render :edit
    end
  end

  def destroy
    redirect_to profile_path, flash: { success: t(".success") } if @price.destroy
  end

  private

  def price_params
    params.require(:price).permit :room_id, :cost, :cleaning_fee,
                                  vouchers_attributes: %i[id code sale date_off _destroy]
  end

  def load_price
    @price = Price.find(params[:id])
  end

  def load_room
    @room = Room.find params[:room_id]
  end
end
