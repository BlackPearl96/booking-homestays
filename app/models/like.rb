# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :room
  belongs_to :user

  # delegate :title, to: :book, prefix: :book, allow_nil: true

  scope :by_like_member, (lambda do |user_id, room_id|
    where user_id: user_id, room_id: room_id
  end)
end
