class ProductsController < ApplicationController
  def index
    @products = Product.published
  end

  def show
    @product = Product.find(product_id)
  end

  private

  def product_id
    params[:id]
  end
end