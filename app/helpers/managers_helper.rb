# frozen_string_literal: true

module ManagersHelper
  def select_of_types
    Room.type_rooms.keys.map { |t| [t.titleize, t] }
  end

  def build_location_for_rooms
    Location.sort_by_name.map { |l| [l.name, l.id] }
  end

  def build_area_to_location
    Area.sort_by_name.map { |a| [a.name, a.id] }
  end

  def build_favorite_space_for_rooms
    FavoriteSpace.sort_by_name.map { |fs| [fs.name, fs.id] }
  end

  def bill_vouchers(price_bill)
    (price_bill.price.cost - ((price_bill.price.cost * price_bill.voucher.sale) / 100)) + price_bill.price.cleaning_fee
  end

  def select_favorite_space
    FavoriteSpace.all.map { |f| [f.name, f.id] }
  end

  def select_room
    Room.all.map { |r| [r.name, r.id] }
  end

  def select_status
    Trend.statuses.keys.map { |s| [s.titleize, s] }
  end

  def set_status(object)
    if object.active?
      link_to("Active", convert_status_manager_trend_path(object),
              method: :patch, remote: true, class: "btn info custom-btn", id: "btn-set-#{object.id}")
    else
      link_to("Inactive", convert_status_manager_trend_path(object),
              method: :patch, remote: true, class: "btn info custom-btn", id: "btn-set-#{object.id}")
    end
  end

  def set_utilities
    Utility.sort_by_name
  end

  def like?(room)
    current_member.likes.find_by(room_id: room.id).present?
  end
end
