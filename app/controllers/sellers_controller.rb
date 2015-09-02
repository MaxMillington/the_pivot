class SellersController < ApplicationController

  def index
    @sellers = Seller.all
  end

  def show
    @seller = Seller.find(params[:seller])
  end

  def update
    @seller = Seller.find(params[:id])
    seller_slug = @seller.slug
    if @seller.update(seller_params) 
      flash.keep[:success] = "Your business information has been updated." 
      seller = Seller.find(params[:id])
      redirect_to seller_dashboard_path(seller.slug)
    else
      flash.keep[:warning] = @seller.errors.full_messages.join(". ")
      redirect_to seller_dashboard_path(seller_slug)
    end
  end

  def new
    @seller = Seller.new
  end

  def create
    @seller = Seller.new(seller_params)

    if @seller.save
      flash[:success] = "Successfully created new seller."
      redirect_to platform_admin_sellers_path(@seller.slug)
    else
      flash.now[:warning] = @seller.errors.full_messages.join(". ")
      render :new
    end
  end

  private

  def seller_params
    params.require(:seller).permit(:name, :email)
  end

end
