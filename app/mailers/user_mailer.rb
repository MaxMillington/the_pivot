class UserMailer < ApplicationMailer

  def account_creation(user)
    @user = user
    mail(
        to: @user.email,
        subject: "Welcome to Collector's World #{@user.full_name}!",
    )
  end

  def contact(winner)
    @winner = winner

    mail(
        to: @winner.email,
        subject: "You won an auction #{@winner.name}!",
    )
  end
end
