class ProductsController < ApplicationController
  def index
    @products = Product.published
  end

  def show
    @product = Product.find(product_id)
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(product_id)
    render :new
  end

  private

  def product_id
    params[:id]
  end
end