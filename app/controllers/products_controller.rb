class ProductsController < ApplicationController

  http_basic_authenticate_with name: "jer", password: "secret", except: [:index, :show]

  def admin
    @products = Product.all
    render 'admin'
  end

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    @products = Product.all
    if @product.save
      redirect_to admin_path
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    @products = Product.all
    if @product.update(product_params)
      redirect_to admin_path
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:title, :image_url, :stock, :price)
  end

end
