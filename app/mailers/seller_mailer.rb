class SellerMailer < ApplicationMailer

  def send_seller_bid_email(seller)
    @seller = seller
    mail(
        to: @seller.email,
        subject: "Your auction has a new bid!",
    )
  end

  def send_auction_over_email(seller)
    @seller = seller
    mail(
        to: @seller.email,
        subject: "Your auction is over!",
    )
  end
end
