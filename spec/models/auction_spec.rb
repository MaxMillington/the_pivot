require "rails_helper"

RSpec.describe Auction, type: :model do
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
        starting_time: DateTime.now - 4.days,
        ending_time: DateTime.now + 4.days,
        starting_price: 50
    )

    @bid = Bid.create(
        auction_id: @auction.id,
        user_id: @user1.id,
        amount: 150
    )


  end

  it "auction is active" do
    expect(Auction.active.first.id).to eq(@auction.id)
  end

  it "it knows the winning bid amount" do
    @ended_auction = Auction.create(
        product_id: @product.id,
        starting_time: DateTime.now - 4.days,
        ending_time: DateTime.now - 2.days,
        starting_price: 50
    )

    @win_bid = Bid.create(
      auction_id: @ended_auction.id,
      user_id: @user1.id,
      amount: 100,
      created_at: DateTime.now - 3.days
    )

    expect(@ended_auction.winning_bid_amount).to eq(100)

  end

  it "it knows the winner if there's a bid" do
    @ended_auction = Auction.create(
        product_id: @product.id,
        starting_time: DateTime.now - 4.days,
        ending_time: DateTime.now - 2.days,
        starting_price: 50
    )

    @win_bid = Bid.create(
        auction_id: @ended_auction.id,
        user_id: @user1.id,
        amount: 100,
        created_at: DateTime.now - 3.days
    )

    expect(@ended_auction.winner).to eq("Alex Tideman")

  end

  it "it knows there is no winner if there's no bid" do
    @ended_auction = Auction.create(
        product_id: @product.id,
        starting_time: DateTime.now - 4.days,
        ending_time: DateTime.now - 2.days,
        starting_price: 50
    )


    expect(@ended_auction.winner).to eq("-")

  end

  it "it knows auction status" do
    @ended_auction = Auction.create(
        product_id: @product.id,
        starting_time: DateTime.now - 4.days,
        ending_time: DateTime.now - 2.days,
        starting_price: 50
    )
    @future_auction = Auction.create(
        product_id: @product.id,
        starting_time: DateTime.now + 2.days,
        ending_time: DateTime.now + 4.days,
        starting_price: 50
    )


    expect(@ended_auction.status).to eq("ended")
    expect(@auction.status).to eq("active")
    expect(@future_auction.status).to eq("scheduled")
  end

end
