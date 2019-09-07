# frozen_string_literal: true

class TrendRoom < ApplicationRecord
  belongs_to :trend
  belongs_to :room
end
