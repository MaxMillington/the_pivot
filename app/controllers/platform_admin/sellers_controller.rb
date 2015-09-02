class PlatformAdmin::SellersController < ApplicationController

  def new
    @seller = Seller.new
  end

  def create
    @seller = Seller.new(seller_params)

    if @seller.save
      flash[:success] = "Successfully created new seller."
      redirect_to platform_admin_dashboard_path
    else
      flash.now[:warning] = @seller.errors.full_messages.join(". ")
      render :new
    end
  end

  def destroy
    @seller = Seller.find(params[:id])
    @seller.destroy
    flash[:success] = "Successfully deleted seller."
    redirect_to platform_admin_dashboard_path
  end

  private

  def seller_params
    params.require(:seller).permit(:name, :email)
  end

end
