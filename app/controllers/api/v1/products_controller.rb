# frozen_string_literal: true

class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_product, only: %i[show update destroy]

  def index
    @products = current_api_user.products.all

    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @product = current_api_user.products.new(product_params)

    if @product.save
      render json: @product, status: :created, location: api_product_url(@product)
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  private

  def set_product
    @product = current_api_user.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :quantity, :price, :active)
  end
end
