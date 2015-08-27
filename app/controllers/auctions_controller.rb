class AuctionsController < ApplicationController
  def index
    @categories = Category.all
    @auctions = Auction.where('starting_time <= ?', Time.now).where('ending_time >= ?', Time.now)
  end

  def show
    @auction = Auction.find(params[:id])
  end

  private

end
