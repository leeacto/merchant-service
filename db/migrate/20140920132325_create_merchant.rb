class CreateMerchant < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.integer :ttl, null: false, default: 0
      t.integer :hashed_screen_name, limit: 8, null: false, default: 0
      t.string :email_address, null: false
      t.timestamps
    end
  end
end
