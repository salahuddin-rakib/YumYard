require 'rails_helper'

RSpec.describe 'FoodsController', type: :request do

  describe 'GET/foods' do
    let(:make_request) do
      get foods_path
    end

    before do
      make_request
    end

    it 'returns response with food array' do
      expect(json.size).to eq(3)
      expect(json["foods"].class.name).to eq('Array')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'Should create a new food' do
      expect(json["total"]).to eq(Food.count)
    end
  end

  describe 'Create/Food' do
    let(:make_request1) do
      post foods_path(
             name: Faker::Name.name,
             image_url: "https://#{Faker::Internet.domain_name}",
             stock_quantity: rand(1..50),
             price: rand(100..1000),
             category: Food.categories.keys.sample)
    end

    let(:make_request2) do
      post foods_path(
             name: Faker::Name.name,
             image_url: "https://#{Faker::Internet.domain_name}",
             stock_quantity: rand(1..50),
             price: rand(100..1000),
             category: Food.categories.keys.sample)
    end

    before do
      make_request1
    end

    it 'returns success response' do
      expect(json.size).to eq(1)
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(:created)
    end

    it 'Should create a new food' do
      expect { with_success_response { make_request2 } }
        .to change { Food.count }.by(+1)
    end
  end
end
