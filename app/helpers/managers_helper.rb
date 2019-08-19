# frozen_string_literal: true

module ManagersHelper
  def select_of_types
    Room.type_rooms.keys.map { |t| [t.titleize, t] }
  end

  def build_location_for_rooms
    Location.sort_by_name.map { |l| [l.name, l.id] }
  end

  def bill_vouchers(price_bill)
    (price_bill.price.cost - ((price_bill.price.cost * price_bill.voucher.sale) / 100)) + price_bill.price.cleaning_fee
  end

  def set_utilities
    Utility.sort_by_name
  end
end
