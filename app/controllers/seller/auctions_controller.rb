class Seller::AuctionsController < ApplicationController
  def new
    @auction = Auction.new(product_id: params[:product_id],
                           category_id: params[:category_id])
    @seller = Seller.find_by(slug: params[:seller])
  end

  def create
    @auction = Auction.new(auction_params)
    # starting_time: DateTime.civil(2015, 07, 05, 21, 33, 0),
    starting_time = DateTime.civil(params[:starting_time][:year].to_i,
                                   params[:starting_time][:month].to_i,
                                   params[:starting_time][:day].to_i,
                                   params[:starting_time][:hour].to_i,
                                   params[:starting_time][:minute].to_i,
                                   0)

    ending_time = DateTime.civil(params[:ending_time][:year].to_i,
                                 params[:ending_time][:month].to_i,
                                 params[:ending_time][:day].to_i,
                                 params[:ending_time][:hour].to_i,
                                 params[:ending_time][:minute].to_i,
                                 0)

    @auction.update_attributes(starting_time: starting_time,
                               ending_time: ending_time)

    if @auction.save
      flash[:success] = "Your new auction has been scheduled."
      redirect_to seller_dashboard_path(params[:seller])
    else
      render :new
    end
  end

  private

  def auction_params
    params.require(:auction).permit(:product_id,
                                    :starting_price)
  end
end
