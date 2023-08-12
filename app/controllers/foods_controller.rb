class FoodsController < ApplicationController
  before_action :find_food, only: [:update]

  def index
    foods = Food.all.select(:id, :name, :image_url, :stock_quantity, :price, :category)
    @foods = paginate_records(foods, params) # Pagination
    render json: { message: 'Successfully fetched food list.', foods: @foods, total: foods.size }, adapter: :json, key_transform: :camel_lower, root: false
  rescue => error
    Rails.logger.error "\nUnable to fetch food list due to: #{error.message}\n"
    render json: { message: 'Unable to fetch food list.' }, status: :unprocessable_entity
  end

  def create
    Food.create!(permitted_params)
    render json: { message: 'Successfully created food.' }, status: :created, root: false
  rescue => error
    Rails.logger.error "\nUnable to create food due to: #{error.message}\n"
    render json: { message: 'Unable to create food.' }, status: :unprocessable_entity
  end

  def update
    @food.update!(permitted_params)
    render json: { message: 'Successfully updated food.' }, adapter: :json, key_transform: :camel_lower, root: false
  rescue => error
    Rails.logger.error "\nUnable to update food due to: #{error.message}\n"
    render json: { message: 'Unable to update food.' }, status: :unprocessable_entity
  end

  private

  def permitted_params
    params.permit(:id, :name, :image_url, :stock_quantity, :price, :category)
  end

  def find_food
    @food = Food.find(permitted_params[:id])
  rescue => _e
    render json: { message: 'Unable to find food.' }, status: :not_found
  end
end
