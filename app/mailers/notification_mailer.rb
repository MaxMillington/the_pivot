class NotificationMailer < ApplicationMailer
  def contact(winner)
    @winner = winner

    mail(
        to: winner.email,
        subject: "Message from #{winner.name}",
    )
  end
end
