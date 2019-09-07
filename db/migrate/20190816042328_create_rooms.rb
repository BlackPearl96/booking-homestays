class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.string :name
      t.string :address
      t.decimal :rate_point
      t.text :description
      t.integer :guest
      t.integer :type_room, default: 0
      t.decimal :acreage
      t.integer :bed_room
      t.integer :bath_room
      t.integer :code_room

      t.timestamps
    end
  end
end
