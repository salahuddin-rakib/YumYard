FactoryBot.define do
  factory :coupon do
    food

    offer_amount { rand(100..200) }
  end
end
