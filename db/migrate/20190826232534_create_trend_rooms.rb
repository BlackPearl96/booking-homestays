class CreateTrendRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :trend_rooms do |t|
      t.references :trend, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
