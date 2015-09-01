class UserMailer < ApplicationMailer

  def account_creation(user)
    @user = user
    mail(
        to: @user.email,
        subject: "Welcome to Collector's World #{@user.full_name}!",
    )
  end

  def send_outbid_email(loser)
    @loser = loser
    mail(
        to: @loser.email,
        subject: "You have been outbid!",
    )
  end

  def send_seller_bid_email(seller)
    @seller = seller
    mail(
        to: @seller.email,
        subject: "Your auction has a new bid!",
    )
  end

  def win_bid(winner)
    @winner = winner
    mail(
        to: @winner.email,
        subject: "You won an auction #{@winner.name}!",
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
