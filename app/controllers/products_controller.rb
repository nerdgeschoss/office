class ProductsController < ApplicationController
  before_action :load_products, except: [:index, :create]

  def index
    @products = policy_scope(Product).alphabetical
  end

  def show
  end

  def create
    @product = authorize Product.new product_params
    if @product.save
      redirect_to @product
    else
      index
      render :index
    end
  end

  def update
    @product.assign_attributes product_params
    if @product.save
      redirect_to @product
    else
      render :show
    end
  end

  private

  def load_products
    @product = authorize Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :available_in_kiosk, :price, :vat, :vat_rate, :deprecated, :image)
  end
end
