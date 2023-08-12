class CouponsController < ApplicationController
  before_action :find_coupon, only: [:destroy]

  def create
    coupon = Coupon.new(
      food_id: permitted_params[:food_id],
      offer_amount: permitted_params[:offer_amount]
    )
    coupon.save!
    render json: { message: 'Successfully created coupon.', coupon: coupon }, status: :created, adapter: :json, key_transform: :camel_lower, root: false
  rescue => error
    Rails.logger.error "\nUnable to create coupon due to: #{error.message}\n"
    render json: { message: 'Unable to create coupon.' }, status: :unprocessable_entity
  end

  def destroy
    @coupon.destroy!
    render json: { message: 'Successfully deleted coupon.' }, status: :ok
  rescue => error
    Rails.logger.error "\nUnable to delete coupon due to: #{error.message}\n"
    render json: { message: 'Unable to delete coupon.' }, status: :unprocessable_entity
  end

  private

  def permitted_params
    params.permit(:id, :food_id, :status, :token, :offer_amount, :expires_at)
  end

  def find_coupon
    @coupon = Coupon.find(permitted_params[:id])
  rescue => _e
    render json: { message: 'Unable to find coupon.' }, status: :not_found
  end
end
