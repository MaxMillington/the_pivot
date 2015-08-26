class ProductsController < ApplicationController
  def index
    @all_products = Product.all
    @categories = Category.all
    @products = Product.find_by(category_id: params[:category_id])
  end

  def show
    load_featured_products
    @product = Product.find(params[:id])
  end
end
