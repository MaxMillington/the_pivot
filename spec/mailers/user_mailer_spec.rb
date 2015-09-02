require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  scenario "User receives email when account created" do

    @user = User.create(first_name: "Bob", last_name: "Jones", email: "alex.tideman@gmail.com",
                        password: "password")
    mail = UserMailer.account_creation(@user)
    assert_equal "Welcome to Collector's World Bob Jones!", mail.subject
    assert_equal ["alex.tideman@gmail.com"], mail.to
    assert_equal ["hello@collectorsworld.com"], mail.from
    assert_match "Thanks", mail.body.encoded
  end

  scenario "User receives email when outbid" do

    @user1 = User.create(first_name: "Bob", last_name: "Jones", email: "alex.tideman@gmail.com",
                        password: "password")
    @user2 = User.create(first_name: "Jane", last_name: "Doe", email: "janedoe@gmail.com",
                        password: "password")

    seller = Seller.create(
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

    Bid.create(
        user_id: @user2.id,
        auction_id: 1,
        amount: 800.00)

    mail = UserMailer.send_outbid_email(@user1)
    assert_equal "You have been outbid!", mail.subject
    assert_equal ["alex.tideman@gmail.com"], mail.to
    assert_equal ["hello@collectorsworld.com"], mail.from
    assert_match "outbid", mail.body.encoded
  end
end
