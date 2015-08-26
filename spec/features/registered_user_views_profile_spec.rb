require "rails_helper"

feature "Registered user can view user profile" do
  before(:each) do
    user1 = User.create(first_name: "Jane",
                       last_name:  "Doe",
                       email:      "jane@doe.com",
                       password:   "password")

    user2 = User.create(first_name: "Joe",
                       last_name:  "Doe",
                       email:      "joe@doe.com",
                       password:   "password")

    user1.addresses.create(type_of:   "billing",
                          address_1: "1313 Mockingbird Ln",
                          address_2: "Ste 13",
                          city:      "Walla Walla",
                          state:     "PA",
                          zip_code:  "13131")

    user1.addresses.create(type_of:   "shipping",
                          address_1: "123 Sesame St",
                          address_2: "Apt 123",
                          city:      "New York",
                          state:     "NY",
                          zip_code:  "12345")

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user1)

    category = Category.create(name: "Comics",
                               description: "This is the description.")

    seller = Seller.create(name: "Store 1",
                           email: "store1@example.com")

    product = seller.products.create(name: "The Amazing Spider-Man",
                                     description: "This is the product's description",
                                     category_id: category.id,
                                     condition: "fair")

    @auction = Auction.create(product_id: product.id,
                   starting_price: 10.00,
                   starting_time: DateTime.civil(2015, 07, 05, 21, 33, 0),
                   ending_time: DateTime.civil(2015, 07, 07, 21, 33, 0)) 

    @auction.bids.create(amount: 15.00,
                         user_id: user1.id)

    @auction.bids.create(amount: 16.00,
                         user_id: user2.id)

  end

  scenario "User visits profile and sees all User info" do
    visit profile_path

    expect(page).to have_content("Jane")
    expect(page).to have_content("Doe")
    expect(page).to have_content("jane@doe.com")

    within("#billing-address") do
      expect(page).to have_content("1313 Mockingbird Ln")
      expect(page).to have_content("Ste 13")
      expect(page).to have_content("Walla Walla")
      expect(page).to have_content("PA")
      expect(page).to have_content("13131")
    end

    within("#shipping-address") do
      expect(page).to have_content("123 Sesame St")
      expect(page).to have_content("Apt 123")
      expect(page).to have_content("New York")
      expect(page).to have_content("NY")
      expect(page).to have_content("12345")
    end
  end

  scenario "User visists profile and sees auction history" do
    visit profile_path

    within('tr', text: "# #{@auction.id}") do
      expect(page).to have_content("The Amazing Spider-Man")
      expect(page).to have_content("July  7, 2015 at  9:33 PM")
      expect(page).to have_content(@auction.winning_bid_amount)
      expect(page).to have_xpath("//a[@href=\"#{auction_path(@auction)}\"]")
    end

  end
end
