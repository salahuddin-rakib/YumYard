require 'rails_helper'

RSpec.describe 'CouponsController', type: :request do
  describe 'Create/Coupon' do
    let(:food1) { create(:food, price: 500) }
    let(:food2) { create(:food, price: 700) }
    let(:make_request1) do
      post coupons_path(food_id: food1.id, offer_amount: 200)
    end

    let(:make_request2) do
      post coupons_path(food_id: food2.id, offer_amount: 100)
    end

    before do
      make_request1
    end

    it 'returns success response' do
      expect(json.size).to eq(2)
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(:created)
    end

    it 'Should create a new food' do
      expect { with_success_response { make_request2 } }
        .to change { Coupon.count }.by(+1)
    end
  end

  describe 'Delete/Coupon' do
    let(:food3) { create(:food, price: 500) }
    let!(:coupon3) { create(:coupon, offer_amount: 200, food: food3) }
    let(:food4) { create(:food, price: 500) }
    let!(:coupon4) { create(:coupon, offer_amount: 200, food: food4) }
    let(:make_request1) do
      delete "/coupons/#{coupon3.id}"
    end

    let(:make_request2) do
      delete "/coupons/#{coupon4.id}"
    end

    before do
      make_request1
    end

    it 'returns success response' do
      expect(json.size).to eq(1)
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(:success)
    end

    it 'Should delete a coupon' do
      expect { with_success_response { make_request2 } }
        .to change { Coupon.count }.by(-1)
    end
  end
end
