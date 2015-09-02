class PlatformAdmin::SellersController < ApplicationController

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

end
