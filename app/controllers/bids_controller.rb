class BidsController < ApplicationController

  def create
    @bid = Bid.new(bid_params)
    @bid.assign_attributes(user_id: params[:user_id], auction_id: params[:auction_id])
    @auction = Auction.find(params[:auction_id])
    if @bid.save
      flash[:notice] = "You are the high bidder!"
      redirect_to auction_path(@bid.auction.id)
    else
      flash[:error] = "Bid amount needs to be greater than current bid"
      redirect_to auction_path(@bid.auction.id)
    end
  end


  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
