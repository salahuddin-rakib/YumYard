require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { create(:food) }
  let!(:coupon) { create(:coupon, food:) }

  it "offer_amount must be grater than 1" do
    expect(coupon.offer_amount).to be >= 1
  end

  it "expires_at expires within 2 minutes" do
    expect(coupon.expires_at.to_i).to be < (Time.now + 3.minutes).to_i
  end
end
