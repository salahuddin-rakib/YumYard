require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:food) { create(:food, price: 100) }
  let!(:coupon) { create(:coupon, offer_amount: 20, food:) }
  let!(:order) { create(:order, food:, coupon:) }

  it "quantity and total_price must be grater than 1" do
    expect(order.quantity).to be >= 1
    expect(order.total_price).to be >= 1
  end
end
