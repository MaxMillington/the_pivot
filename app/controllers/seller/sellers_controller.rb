class Seller::SellersController < ApplicationController
  before_action :authorize_seller_admin, only: [:index, :show, :edit, :update]

  def index
    @sellers = Seller.all
  end

  def show
  end

  def edit
    @seller = Seller.find_by(slug: params[:seller])
  end

  def update
    @seller = Seller.find_by(slug: params[:seller])
    @seller = Seller.update(seller_params) 
    redirect_to seller_dashboard_path(@seller.slug)
  end

  private

  def seller_params
    params.require(:seller1).permit(:name, :email)
  end

  def authorize_seller_admin
    unless current_user.seller.id == current_seller.id
      flash[:warning] = "This page doesn't exist."
      redirect_to root_path
    end    
  end
end
