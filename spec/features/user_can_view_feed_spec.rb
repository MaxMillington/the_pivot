require "rails_helper"

feature "User can view feed page with active bids" do
  before do

    seller = Seller.create(
      name: "IBM Inc.",
      email: "home@ibm.com"
    )

    category = Category.create(
      name: "Toys",
      description: "Toys are fun!"
    )

    product = seller.products.create(
      category_id: category.id,
      name: "Computer",
      description: "This computer is really fast!",
      condition: "good"
    )

    auction = Auction.create(
      product_id: product.id,
      starting_time:  DateTime.now,
      ending_time:    DateTime.now + 5.days,
      starting_price: 500.00
    )

    user1 = User.create(
      first_name: "Jane",
      last_name:  "Doe",
      email:      "jane@doe.com",
      password:   "password")

    user2 = User.create(
      first_name: "Johnny",
      last_name:  "Appleseed",
      email:      "john@doe.com",
      password:   "password")

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user2)

    visit root_path
    click_link "Auctions"
  end

  scenario "bid on auction and see in feed" do
    click_link "Computer"
    fill_in "Amount", with: "600.00"
    click_button 'Create Bid'
    click_link_or_button("Feed")
    expect(page).to have_content("Computer")
    expect(page).to have_content("You are the current High Bidder!")
    expect(page).to have_content("Your Current High Bid: $600.00")
  end

  scenario "bid on auction, someone else out bids you and see in feed" do

    click_link "Computer"
    fill_in "Amount", with: "600.00"
    click_button 'Create Bid'
    click_link_or_button("Feed")
    expect(page).to have_content("Computer")
    expect(page).to have_content("You are the current High Bidder!")
    expect(page).to have_content("Your Current High Bid: $600.00")

    Bid.create(
      user_id: 1,
      auction_id: 1,
      amount: 700.00)

    click_link_or_button("Feed")
    expect(page).to have_content("Computer")
    expect(page).to have_content("Current High Bidder: Jane Doe")
    expect(page).to have_content("Current Bid: $700.00")

    click_link "Auctions"
    click_link "Computer"
    fill_in "Amount", with: "800.00"
    click_button 'Create Bid'
    click_link_or_button("Feed")
    expect(page).to have_content("Computer")
    expect(page).to have_content("You are the current High Bidder!")
    expect(page).to have_content("Your Current High Bid: $800.00")
  end

  scenario "bid on auction from the feed page" do

    click_link "Computer"
    fill_in "Amount", with: "600.00"
    click_button 'Create Bid'
    click_link_or_button("Feed")
    expect(page).to have_content("Computer")
    expect(page).to have_content("You are the current High Bidder!")
    expect(page).to have_content("Your Current High Bid: $600.00")

    Bid.create(
      user_id: 1,
      auction_id: 1,
      amount: 700.00)

    click_link_or_button("Feed")
    expect(page).to have_content("Computer")
    expect(page).to have_content("Current High Bidder: Jane Doe")
    expect(page).to have_content("Current Bid: $700.00")

    fill_in "Amount", with: "900.00"
    click_button 'Create Bid'
    expect(page).to have_content("Computer")
    expect(page).to have_content("Current High Bidder: Johnny Appleseed")
    expect(page).to have_content("Current Bid: $900.00")
  end
end
