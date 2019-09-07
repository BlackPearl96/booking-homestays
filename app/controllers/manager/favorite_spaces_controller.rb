# frozen_string_literal: true

module Manager
  class FavoriteSpacesController < BaseController
    before_action :favorite_space, only: %i[edit update destroy]

    def index
      @favorite_spaces = FavoriteSpace.newest.page(params[:page]).per Settings.favorite_per
    end

    def new
      @favorite_space = FavoriteSpace.new
    end

    def create
      @favorite_space = FavoriteSpace.new(favorite_space_params)
      if @favorite_space.save
        redirect_to manager_favorite_spaces_path, flash: { success: t(".success") }
      else
        render :new
      end
    end

    def edit; end

    def update
      if @favorite_space.update_attributes(favorite_space_params)
        redirect_to manager_favorite_spaces_path, flash: { success: t(".success") }
      else
        render :edit
      end
    end

    def destroy
      redirect_to manager_favorite_spaces_path, flash: { success: t(".success") } if @favorite_space.destroy
    end

    private

    def favorite_space_params
      params.require(:favorite_space).permit(:name)
    end

    def favorite_space
      @favorite_space = FavoriteSpace.find(params[:id])
    end
  end
end
