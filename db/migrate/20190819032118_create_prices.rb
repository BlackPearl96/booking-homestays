class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.decimal :cost, precision: 8, scale: 2
      t.decimal :cleaning_fee, precision: 8, scale: 2, default: 0

      t.timestamps
    end
  end
end
