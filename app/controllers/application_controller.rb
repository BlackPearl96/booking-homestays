# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :danger, :warning, :info
  devise_group :user, contains: %i[admin member]
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError do
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

  def after_sign_in_path_for(resource)
    link = resource.type == "Admin" ? manager_root_path : root_path
    stored_location_for(resource) || link
  end

  def after_sign_out_path_for(resource_or_scope)
    resource_or_scope == :admin ? new_admin_session_path : root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email address password password_confirmation avatar])
    devise_parameter_sanitizer
      .permit(:account_update, keys: %i[name email address password password_confirmation avatar current_password])
  end
end
