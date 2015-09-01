class Seller::SellersController < ApplicationController

  def index
    @sellers = Seller.all
  end

  def show
  end

  def new
    @seller = Seller.new
  end

  def create
    @seller = Seller.new(seller_params)

    if @seller.save
      flash[:success] = "Successfully created new seller."
      redirect_to seller_dashboard_path(@seller.slug)
    else
      flash.now[:warning] = @seller.errors.full_messages.join(". ")
      render :new
    end

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

end
