# frozen_string_literal: true

module Manager
  class AdminsController < BaseController
    before_action :load_admin, only: %i[edit update]

    def index
      @admins = Admin.all
    end

    def new
      @admin = Admin.new
    end

    def create
      @admin = Admin.new admin_params
      if @admin.save
        flash[:success] = t "messages.success.admins.create"
      else
        flash[:danger] = t "messages.failed.admins.create"
      end
      respond_to do |format|
        format.js
      end
    end

    def edit; end

    def update
      @admin.not_update_password = true if admin_params[:password].blank? && admin_params[:password_confirmation].blank?
      @admin.assign_attributes admin_params
      if @admin.changed?
        update_admin @admin
      else
        flash[:notice] = t("messages.notice.admins.not_edit", id: @admin.id.to_s)
      end
    end

    private

    def load_admin
      @admin = Admin.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit :email, :name, :address,
                                    :password, :password_confirmation, :avatar
    end

    def update_admin(admin)
      if admin.save
        flash[:success] = t("messages.success.admins.update", id: admin.id.to_s)
      else
        respond_to do |format|
          format.js { flash[:danger] = t("messages.failed.admins.update", id: admin.id.to_s) }
        end
      end
    end
  end
end