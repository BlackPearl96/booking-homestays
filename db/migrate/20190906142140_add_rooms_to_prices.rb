class AddRoomsToPrices < ActiveRecord::Migration[5.2]
  def change
    add_reference :prices, :room, foreign_key: true
  end
end
