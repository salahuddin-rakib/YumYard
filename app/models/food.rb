class Food < ApplicationRecord

  # Associations:
  has_many :coupons
  has_one :order

  # Enumerable:
  enum category: { appetizer: 0, main_course: 1, dessert: 2 }
end
