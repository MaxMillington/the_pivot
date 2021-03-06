class Seller::AuctionsController < ApplicationController
  before_action :authorize_seller_admin, only: [:index, :new, :create]

  def index
    @categories = Category.all
    @seller = Seller.find_by(slug: params[:seller])
    @auctions = @seller.auctions.paginate(:page => params[:page], :per_page => 20)
    if params[:category_id]
      category_id = params.permit(:category_id)[:category_id]
      @auctions = @auctions.joins(:category).where(categories: { id: category_id })
    end
  end

  def new
    @auction = Auction.new(product_id: params[:product_id])
    @seller = Seller.find_by(slug: params[:seller])
  end

  def create
    @auction = Auction.new(auction_params)
    @seller = Seller.find_by(slug: params[:seller])
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
      # SellerNotifier.perform_in((TimeDifference.between(starting_time,ending_time).in_minutes.to_i).minutes, @seller)
      # UserNotifier.perform_in((TimeDifference.between(starting_time,ending_time).in_minutes.to_i).minutes, @auction)
      redirect_to seller_dashboard_path(params[:seller])
    else
      @seller = Seller.find_by(slug: params[:seller])
      flash[:warning] = "You must enter valid information"
      render :new
    end
  end

  private

  def auction_params
    params.require(:auction).permit(:product_id,
                                    :starting_price)
  end

  def filtering_params(params)
    params.slice(:category_id)
  end

  def authorize_seller_admin
    unless current_user.platform_admin? || (current_user.seller.id == current_seller.id) 
      flash[:warning] = "This page doesn't exist."
      redirect_to root_path
    end    
  end
end
