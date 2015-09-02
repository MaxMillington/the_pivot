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


  def win_bid(winner)
    @winner = winner
    mail(
        to: @winner.email,
        subject: "You won an auction #{@winner.name}!",
    )
  end

end
