class CreateMerchantTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :merchant_transactions do |t|
      t.belongs_to :merchant_location
      t.string :square_id
      t.string :transaction_date
      t.string :product
      t.string :shipping_address

      t.timestamps
    end

    add_index :merchant_transactions, :square_id, :unique => true
  end
end
