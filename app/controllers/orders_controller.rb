class OrdersController < ApplicationController
  before_action :find_food, only: [:order]

  def process_order
    coupon = Coupon.find_by(token: permitted_params[:coupon_token])
    if permitted_params[:coupon_token].present? && (coupon.blank? || coupon.is_expired?)
      render json: { message: 'Please give a valid coupon.' }, status: :not_acceptable
    elsif params[:total_ordered] > @food.stock_quantity
      render json: { message: "We do not have #{permitted_params[:total_ordered]} quantity of #{@food.name}."}, status: :not_acceptable
    else
      return_flag = Order.place(@food, coupon, permitted_params)
      if return_flag
        render json: { message: 'Order place successful.' }, status: :ok
      else
        render json: { message: 'Unable to place order.' }, status: :unprocessable_entity
      end
    end
  rescue => error
    Rails.logger.error "\nUnable to place order due to: #{error.message}\n"
    render json: { message: 'Unable to place order.' }, status: :unprocessable_entity
  end

  private

  def permitted_params
    params.permit(:food_id, :price, :total_ordered, :coupon_token)
  end

  def find_food
    @food = Food.find(permitted_params[:food_id])
  rescue => _e
    render json: { message: 'Unable to find food.' }, status: :not_found
  end
end
