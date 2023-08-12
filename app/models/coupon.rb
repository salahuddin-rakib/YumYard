class Coupon < ApplicationRecord
  # Associations:
  belongs_to :food

  # Model callback:
  before_save :set_expires_at
  before_save :set_token

  # Validations:
  validate :check_if_active_coupon_exist
  validate :check_offer_amount

  # Enumerable:
  enum status: { active: 0, disabled: 1 }

  private

  def set_expires_at
    self.expires_at = Time.now + 2.minutes
  end

  def set_token
    self.token = SecureRandom.alphanumeric(8)
  end

  def check_if_active_coupon_exist
    if Coupon.find_by(food_id: self.food_id, status: :active)
      errors.add(:base, "Active coupon already exist.")
    end
  end

  # Check if offer price is between 10 to 50% of food item price.
  def check_offer_amount
    price = Food.find_by(id: self.food_id)&.price || 1
    offer_amount = self.offer_amount || 1
    coupon_percentage = 100 / (price / offer_amount)
    if coupon_percentage < 10 || coupon_percentage > 50
      errors.add(:offer_amount, "needs to be between 10 to 50% of food price.")
    end
  end
end
