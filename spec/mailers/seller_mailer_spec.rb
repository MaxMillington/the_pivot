require "rails_helper"

RSpec.describe SellerMailer, type: :mailer do

  scenario "Seller receives email when a new bid" do

    @user1 = User.create(first_name: "Bob", last_name: "Jones", email: "alex.tideman@gmail.com",
                         password: "password")
    @seller = Seller.create(
        name: "IBM Inc.",
        email: "home@ibm.com"
    )

    category = Category.create(
        name: "Toys",
        description: "Toys are fun!"
    )

    product = Product.create(
        category_id: 1,
        name: "Computer",
        description: "This computer is really fast!",
        condition: "good",
        seller_id:  1,
    )

    auction = Auction.create(
        product_id: 1,
        starting_time:  DateTime.now,
        ending_time:    DateTime.now + 5.days,
        starting_price: 500.00)

    Bid.create(
        user_id: @user1.id,
        auction_id: 1,
        amount: 700.00)

    mail = SellerMailer.send_seller_bid_email(@seller)
    assert_equal "Your auction has a new bid!", mail.subject
    assert_equal ["home@ibm.com"], mail.to
    assert_equal ["hello@collectorsworld.com"], mail.from
    assert_match "new bid", mail.body.encoded
  end
end
