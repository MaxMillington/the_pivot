class AuctionsController < ApplicationController
  def index
    @categories = Category.all
    @auctions = Auction.where('starting_time <= ?', Time.now)
                    .where('ending_time >= ?', Time.now)
                    .paginate(:page => params[:page], :per_page => 20)
    filtering_params(params).each do |key, value|
      @auctions = @auctions.public_send(key, value) if value.present?
    end
  end

  def show
    @bid = Bid.new
    @auction = Auction.find(params[:id])
  end

  private

  def filtering_params(params)
    params.slice(:category_id)
  end

end
