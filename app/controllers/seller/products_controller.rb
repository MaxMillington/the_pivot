class Seller::ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :update]

  def index
    @seller = Seller.find_by(slug: params[:seller])
    @categories = Category.all
    @products = Product.where(seller_id: @seller.id).paginate(:page => params[:page], :per_page => 20)
    filtering_params(params).each do |key, value|
      @products = @products.public_send(key, value) if value.present?
    end
  end

  def show
    load_featured_products
    @product = Product.find(params[:id])
  end


  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "#{@product.name} has been added."
      redirect_to admin_dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @product.update(product_params)
    flash[:success] = "#{@product.name} has been updated."
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name,
                                    :description,
                                    :price,
                                    :image_url,
                                    :category_id,
                                    :status)
  end

  def set_product
    @product = Product.find(params[:id])
  end


  private

  def filtering_params(params)
    params.slice(:category_id)
  end
end
