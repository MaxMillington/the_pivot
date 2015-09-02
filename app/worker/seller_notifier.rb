class SellerNotifier
  include Sidekiq::Worker

  def perform(seller)
    SellerMailer.send_auction_over_email(seller).deliver_now
  end
end