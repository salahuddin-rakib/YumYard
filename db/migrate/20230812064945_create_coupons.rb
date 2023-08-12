class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.references :food, null: false, foreign_key: true
      t.integer :status, default: 0
      t.string :token
      t.integer :offer_amount, default: 0
      t.datetime :expires_at

      t.timestamps
    end
  end
end
