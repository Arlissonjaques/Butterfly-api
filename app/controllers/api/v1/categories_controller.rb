class Api::V1::CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :update, :destroy]
  before_action :authenticate_api_user!, only: [:create, :update, :destroy]

  def index
    render json: Category.all
  end
  #------------------------------------------------------
  def show
    render json: @category.products
  end
  #------------------------------------------------------
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end
  #-------------------------------------------------------
  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end
  #-------------------------------------------------------
  def destroy
    @category.destroy
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
  #--------------------------------------------------------
  def category_params
    params.permit(:name, :product_id)
  end
end