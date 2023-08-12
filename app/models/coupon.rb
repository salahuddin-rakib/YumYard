class Coupon < ApplicationRecord
  # Associations:
  belongs_to :food


  # Enumerable:
  enum status: { active: 0, inactive: 1 }
end
