class AuctionsController < ApplicationController
  def index
    @categories = Category.all
    if params[:search]
      @auctions = Auction.active.search(params[:search]).paginate(:page => params[:page], :per_page => 20)
    else
      @auctions = Auction.active.paginate(:page => params[:page], :per_page => 20)
    end
    if params[:category_id]
      category_id = params.permit(:category_id)[:category_id]
      @auctions = @auctions.joins(:category).where(categories: { id: category_id })
    end
  end

  def show
    @bid = Bid.new
    @auction = Auction.find(params[:id])
  end
end
