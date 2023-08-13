FactoryBot.define do
  factory :coupons do
    food

    offer_amount { rand(100..200) }
  end
end
