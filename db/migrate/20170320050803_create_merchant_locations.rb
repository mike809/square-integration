class CreateMerchantLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :merchant_locations do |t|
      t.belongs_to :merchant
      t.string :square_id
      t.string :name
      t.string :timezone

      t.timestamps
    end

    add_index :merchant_locations, :square_id, :unique => true
  end
end
