class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :food, null: false, foreign_key: true
      t.references :coupon, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
