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

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_url
    else
      render :new
    end
  end

  def edit
    @product = Product.find(product_id)
    render :new
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
end