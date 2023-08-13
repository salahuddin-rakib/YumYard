FactoryBot.define do
  factory :food do
    name { Faker::Name.name }
    image_url { "https://#{Faker::Internet.domain_name}" }
    stock_quantity { rand(1..50) }
    price { rand(100..1000) }
    category { Food.categories.keys.sample }
  end
end
