# frozen_string_literal: true

class TrendsController < ApplicationController
  def show
    @trend = Trend.find params[:id]
    @rooms = @trend.rooms.newest.page(params[:page]).per Settings.room_per
  end
end
