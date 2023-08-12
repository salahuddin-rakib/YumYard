class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :image_url
      t.integer :stock_quantity, default: 0
      t.decimal :price, precision: 8, scale: 2
      t.integer :category, default: 0

      t.timestamps
    end
  end
end
