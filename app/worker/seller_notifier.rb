class SellerNotifier
  include Sidekiq::Worker

  def perform(seller_id)
    seller = Seller.find(seller_id)
    SellerMailer.send_auction_over_email(seller).deliver_now
  end
end
