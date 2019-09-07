# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  layout "application"

  protected

  def after_update_path_for(resource)
    index_profile_path(resource)
  end
end
