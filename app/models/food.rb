class Food < ApplicationRecord

  # Associations:
  has_many :coupons
  has_many :orders

  # Validations:
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  # Enumerable:
  enum category: { appetizer: 0, main_course: 1, dessert: 2 }

  # Scopes:
  scope :search_by_category, -> (category) { where(category: category) }
  scope :search_by_name, -> (name_keyword) { where('name ILIKE ?', "%#{name_keyword}%") }
  scope :search_by_price, -> (price, comparison_operator = '=') { where("price #{comparison_operator} ?", price) }
end
