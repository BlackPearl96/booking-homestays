class CreateRoomUtilities < ActiveRecord::Migration[5.2]
  def change
    create_table :room_utilities do |t|
      t.references :room, foreign_key: true
      t.references :utility, foreign_key: true

      t.timestamps
    end
  end
end
