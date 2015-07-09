class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.published
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_url
    else
      render :new
    end
  end

  def edit
    render :new
  end

  def update
    if @product.update(product_params)
      redirect_to products_url
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  private

  def product_id
    params[:id]
  end

  def product_params
    params.require(:product).permit(:title,
                                    :description, 
                                    :price, 
                                    :published, 
                                    :category_id)
  end

  def get_product
    @product = Product.find(product_id)
  end
end