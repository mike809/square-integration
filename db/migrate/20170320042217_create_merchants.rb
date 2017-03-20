class CreateMerchants < ActiveRecord::Migration[5.0]
  def change
    create_table :merchants do |t|
      t.string :access_token,
      t.timestamps
    end

    add_index :merchants, :access_token, :unique => true
  end
end
