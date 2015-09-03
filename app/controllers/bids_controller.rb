class BidsController < ApplicationController

  def create
    @bid = Bid.new(bid_params)
    @bid.assign_attributes(user_id: params[:user_id], auction_id: params[:auction_id])
    @auction = Auction.find(params[:auction_id])
    if @bid.amount.nil?
      flash[:warning] = "You must enter a bid amount."
      redirect_to auction_path(@bid.auction.id)
    elsif @bid.save
      @bid.outbid_user.send_outbid_email_and_text
      flash[:success] = "You are the high bidder!"
      @bid.bid_seller.send_seller_bid_email
      redirect_to auction_path(@bid.auction.id)
    else
      flash[:warning] = "Bid amount needs to be greater than current bid"
      redirect_to auction_path(@bid.auction.id)
    end
  end


  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
