# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @favorite_spaces = FavoriteSpace.newest
    @trends = Trend.newest
  end

  def show
    @favorite_space = FavoriteSpace.find(params[:id])
    @room_favorite_space = @favorite_space.rooms.includes(:price, :location).page(params[:page]).per(16)
  end
end
