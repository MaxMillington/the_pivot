class Seller::ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update]
  before_action :set_seller, only: [:index, :new, :create, :edit, :update]
  before_action :authorize_seller_admin, only: [:index, :show, :new, :create, :update]

  def index
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
    @product.update(seller_id: @seller.id)
    if @product.save
      flash[:success] = "#{@product.name} has been added."
      redirect_to seller_dashboard_path
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    @product.update(product_params)
    flash[:success] = "You successfully edited #{@product.name}."
    redirect_to seller_product_path(@seller.slug, @product.id)
  end

  private

  def product_params
    params.require(:product).permit(:name,
                                    :description,
                                    :condition,
                                    :image_url,
                                    :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_seller
    @seller = Seller.find_by(slug: params[:seller])
  end

  private

  def filtering_params(params)
    params.slice(:category_id)
  end

  def authorize_seller_admin
    unless current_user.platform_admin? || (current_user.seller.id == current_seller.id) 
      flash[:warning] = "This page doesn't exist."
      redirect_to root_path
    end    
  end
end
