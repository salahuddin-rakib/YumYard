FactoryBot.define do
  factory :food do
    food
    coupon

    quantity { rand(1..50) }
    total_price { rand(100..1000) }
  end
end
