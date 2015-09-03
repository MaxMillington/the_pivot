require "rails_helper"

RSpec.describe Bid, type: :model do
  before do
    @seller = Seller.create(
        name: "IBM Inc.",
        email: "home@ibm.com"
    )

    @user1 = User.create(
                    first_name: "Alex",
                    last_name: "Tideman",
                    email: "at@gmail.com",
                    password: "password"
    )

    @user2 = User.create(
        first_name: "Bob",
        last_name: "Jones",
        email: "bj@gmail.com",
        password: "password"
    )

    @category = Category.create(
        name: "Electronics",
        description: "Gadgets galore!"
    )

    @product = Product.create(
        category_id: @category.id,
        name: "Computer",
        description: "This computer is really fast!",
        condition: "good",
        seller_id:  @seller.id,
    )

    @auction = Auction.create(
        product_id: @product.id,
        starting_time: DateTime.now,
        ending_time: DateTime.now + 4.days,
        starting_price: 50
    )

    @bid = Bid.create(
                  auction_id: @auction.id,
                  user_id: @user1.id,
                  amount: 150
    )


  end

  it "it knows its seller" do
    expect(@bid.bid_seller.name).to eq("IBM Inc.")
  end

  it "it knows an outbid user" do
    @bid2 = Bid.create(
        auction_id: @auction.id,
        user_id: @user2.id,
        amount: 200
    )

    expect(@bid2.outbid_user.full_name).to eq("Alex Tideman")

  end

  it "it knows there is no outbid user if only one bid" do
    expect(@bid.outbid_user).to eq(nil)

  end
end
