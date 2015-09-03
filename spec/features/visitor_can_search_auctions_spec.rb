require "rails_helper"

feature "a visitor can search for auctions" do
  before do
    @seller = Seller.create(name: "ACME",
                            email: "hello@acme.com")

    category = Category.create(name: "Comics")
    category2 = Category.create(name: "Instruments")

    @product = @seller.products.create(name: "The Amazing Spider-Man",
                                       category_id: category.id,
                                       description: "The description goes here",
                                       condition: "mint")

    @product2 = @seller.products.create(name: "Gibson Les Paul",
                                        category_id: category2.id,
                                        description: "Guitar",
                                        condition: "mint")

    auction_1 = Auction.create(product_id: @product.id,
                               starting_time: DateTime.now,
                               ending_time: DateTime.now + 2.days,
                               starting_price: 500)

    auction_2 = Auction.create(product_id: @product2.id,
                               starting_time: DateTime.now,
                               ending_time: DateTime.now + 2.days,
                               starting_price: 600)
  end

  scenario "a visitor fills out search and sees auctions" do
    visit root_path
    fill_in "search", with: "amazing"
    click_button "Find It!"
    expect(current_path).to eq(auctions_path)
    expect(page).to have_content("The Amazing Spider-Man")
  end
end
