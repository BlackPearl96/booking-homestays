class RemovePricesFromRooms < ActiveRecord::Migration[5.2]
  def change
    remove_reference :rooms, :price, foreign_key: true
  end
end
