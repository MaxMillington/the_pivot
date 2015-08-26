class ProductsController < ApplicationController
  def index
    @all_products = Product.paginate(:page => params[:page], :per_page => 25)
    @categories = Category.all
    @products = Product.find_by(category_id: params[:category_id])
  end

  def show
    load_featured_products
    @product = Product.find(params[:id])
  end
end
