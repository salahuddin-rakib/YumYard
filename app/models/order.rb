class Order < ApplicationRecord
  # Associations:
  belongs_to :food
  belongs_to :coupon, optional: true

  # Validations:
  validates :quantity, :total_price, numericality: { greater_than_or_equal_to: 1 }

  # class methods
  def self.place(food, coupon, params)
    return_flag = false
    total_ordered = params[:total_ordered].to_i
    ActiveRecord::Base.transaction do
      food.orders.create!(
        quantity: params[:total_ordered],
        coupon: coupon,
        total_price: (params[:price].to_f * total_ordered) - (coupon&.offer_amount || 0),
        )
      food.update!(stock_quantity: food.stock_quantity - total_ordered)
      return_flag = true
    end
    return_flag
  end
end
