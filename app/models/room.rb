# frozen_string_literal: true

class Room < ApplicationRecord
  attr_writer :current_step
  attr_accessor :home, :content

  STEPS = %w[home content confirmation].freeze

  has_many :room_utilities, dependent: :destroy
  has_many :utilities, through: :room_utilities
  belongs_to :location
  belongs_to :user
  belongs_to :favorite_space
  belongs_to :area
  has_many :room_images
  has_one :price

  validates :address, presence: true, length: { maximum: 50 }, if: :step_content?
  validates :name, presence: true, length: { maximum: 50 }, if: :step_home?
  validates :guest, :bed_room, :bath_room, presence: true,
                                           numericality: { only_integer: true }, if: :step_home?
  validates :type_room, presence: true, if: :step_home?

  enum type_room: { private_room: 0, entire: 1 }

  accepts_nested_attributes_for :room_images, allow_destroy: true

  def current_step
    @current_step || STEPS.first
  end

  def next_step
    self.current_step = STEPS[STEPS.index(current_step) + 1]
  end

  def previous_step
    self.current_step = STEPS[STEPS.index(current_step) - 1]
  end

  def first_step?
    current_step == STEPS.first
  end

  def last_step?
    current_step == STEPS.last
  end

  def all_valid?
    STEPS.all? do |step|
      self.current_step = step
      valid?
    end
  end

  private

  def step_content?
    current_step == STEPS[1]
  end

  def step_home?
    current_step == STEPS[0]
  end
end
