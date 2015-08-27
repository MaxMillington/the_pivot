class AuctionsController < ApplicationController
  def index
    @categories = Category.all
    @auctions = Auction.where('starting_time <= ?', Time.now).where('ending_time >= ?', Time.now).paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @auction = Auction.find(params[:id])
  end

end
