class Food < ApplicationRecord

  # Associations:
  has_many :coupons
  has_many :orders

  # Validations:
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  # Enumerable:
  enum category: { appetizer: 0, main_course: 1, dessert: 2 }
end
