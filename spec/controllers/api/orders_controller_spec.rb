require 'rails_helper'

RSpec.describe 'OrdersController', type: :request do
  describe 'Order' do
    let(:food1) { create(:food, price: 100, stock_quantity: 100) }
    let!(:coupon1) { create(:coupon, offer_amount: (food1.price / 3), food: food1) }
    let(:make_request1) do
      post "/api/#{food1.id}/process_order", **as_json_body({
        price: food1.price,
        total_ordered: rand(1..5),
        coupon_token: coupon1.token
      })
    end
    let(:make_request2) do
      post "/api/#{food1.id}/process_order", **as_json_body({
        price: food1.price,
        total_ordered: rand(1..5),
      })
    end

    let(:food2) { create(:food, price: 100, stock_quantity: 100) }
    let!(:coupon2) { create(:coupon, offer_amount: (food2.price / 3), food: food2) }
    let(:make_request3) do
      post "/api/#{food2.id}/process_order", **as_json_body({
        price: food2.price,
        total_ordered: rand(1..5),
        coupon_token: coupon2.token
      })
    end
    let(:make_request4) do
      post "/api/#{food2.id}/process_order", **as_json_body({
        price: food2.price,
        total_ordered: rand(1..5),
      })
    end

    context 'with coupon code' do
      before do
        make_request1
      end

      it 'returns success response' do
        expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'Should create a new order' do
        expect { with_success_response { make_request3 } }
          .to change { Order.count }.by(+1)
      end
    end

    context 'without coupon code' do
      before do
        make_request2
      end

      it 'returns success response' do
        expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'Should create a new order' do
        expect { with_success_response { make_request4 } }
          .to change { Order.count }.by(+1)
      end
    end
  end
end
