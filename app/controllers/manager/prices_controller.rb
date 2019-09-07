# frozen_string_literal: true

module Manager
  class PricesController < BaseController
    before_action :load_price, only: %i[edit update]
    before_action :load_room, only: %i[edit new]

    def index
      @prices = Price.includes(:bills, :vouchers).newest
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
        redirect_to manager_room_path(@price.room_id), flash: { success: t(".success") }
      else
        render :new
      end
    end

    def update
      if @price.update price_params
        redirect_to manager_room_path(@price.room_id), flash: { success: t(".success") }
      else
        render :edit
      end
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
end
