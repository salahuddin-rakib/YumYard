class FoodsController < ApplicationController
  before_action :find_food, only: [:update]

  def index
    foods = filter_foods # Filter implementation
    foods = foods.select(:id, :name, :image_url, :stock_quantity, :price, :category)
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

  def filter_params
    params.permit(:name, :price, :price_compare_operator, :category)
  end

  def find_food
    @food = Food.find(permitted_params[:id])
  rescue => _e
    render json: { message: 'Unable to find food.' }, status: :not_found
  end

  def filter_foods
    foods = Food.all
    if filter_params[:name].present?
      foods = foods.search_by_name(filter_params[:name])
    end

    if filter_params[:price].present? && filter_params[:price_compare_operator].present? && %w(< = >).include?(filter_params[:price_compare_operator])
      foods = foods.search_by_price(filter_params[:price], filter_params[:price_compare_operator])
    end

    if filter_params[:category].present? && Food.categories.keys.include?(filter_params[:category])
      foods = foods.search_by_category(filter_params[:category])
    end

    foods
  end
end
