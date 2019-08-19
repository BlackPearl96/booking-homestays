# frozen_string_literal: true

class Utility < ApplicationRecord
  has_many :room_utilities
  has_many :rooms, through: :room_utilities
end
