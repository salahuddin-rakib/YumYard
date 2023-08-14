# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def food_attributes
  {
    name: Faker::Name.name,
    image_url: "https://#{Faker::Internet.domain_name}",
    stock_quantity: rand(1..50),
    price: rand(100..1000),
    category: Food.categories.keys.sample
  }
end

1..20.times do |index|
  food = Food.create!(food_attributes)
  if index < 5
    Coupon.create(food_id: food.id, offer_amount: (food.price / 3))
  end
end
