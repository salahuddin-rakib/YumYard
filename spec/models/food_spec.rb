require 'rails_helper'

RSpec.describe Food, type: :model do
  it "price must be grater than 1" do
    food = create(:food)
    expect(food.price).to be >= 1
  end
end
