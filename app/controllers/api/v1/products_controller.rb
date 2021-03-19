class Api::V1::ProductsController < ApplicationController

  before_action :set_product, only: [:update, :destroy]

  def index
    render json: Product.all
  end
  #------------------------------------------
  def show

  end
  #------------------------------------------
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  #------------------------------------------
  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  #------------------------------------------
  def destroy
    @product.destroy
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
  #-------------------------------------------
  def product_params
    params.permit(:name, :color, :description, :category_id)
  end
end
