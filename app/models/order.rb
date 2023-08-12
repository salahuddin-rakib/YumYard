class Order < ApplicationRecord
  # Associations:
  belongs_to :food
  belongs_to :coupon, optional: true
end
